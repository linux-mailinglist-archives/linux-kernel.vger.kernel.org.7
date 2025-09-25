Return-Path: <linux-kernel+bounces-833191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068EABA1603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A8E7B83DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CB320CD9;
	Thu, 25 Sep 2025 20:36:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638533203A7;
	Thu, 25 Sep 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832608; cv=none; b=TsiCT8B8OY4AEPP4WCnb8x6v3iqQUsiZ3HfX95y/Q7XWt+lXuvSgd7BL9Z9Zm+DzqRGq0Rtskwa98znmzpqZlDfwtbHrZtpzbT+dRPdPWJ985bhWLbZpYgXLkBo8XexBJPPBWpN/udm5pxkbnpvnxIB+EmtffKzcO3ZuvcaorWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832608; c=relaxed/simple;
	bh=eek8QLsSSuq2WvGDze5TSuJPWIpkvuCu3CnxAI2I+t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PknNNPE/Nd56nWMmcNKTdKmowDRhcCmc9mtTprNInJNmx6jCtjHWF1FGt1QFoBWlZyYXO0zGXAmwaj1gwyJRMCr7Lmdll0VHCRmw8gGvX6rbyLKzE54ubpchFudae4mFCohVsoMHjURnVWyFXQAPxQO9xRWTplDjdD6Q40m69lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FD41692;
	Thu, 25 Sep 2025 13:36:37 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0083F694;
	Thu, 25 Sep 2025 13:36:42 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 08/10] firmware: arm_scmi: Add Telemetry components view
Date: Thu, 25 Sep 2025 21:35:52 +0100
Message-ID: <20250925203554.482371-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925203554.482371-1-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an alternative filesystem view for the discovered Data Events, where
the tree of DEs is laid out following the discovered topological order
instead of the existing flat layout.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../firmware/arm_scmi/scmi_system_telemetry.c | 730 ++++++++++++++++++
 1 file changed, 730 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
index f591aad10302..a4b6d23b211e 100644
--- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -189,6 +189,8 @@ struct scmi_tlm_inode {
  * @all_nodes: An array to keep track of all the initialized TLM nodes that
  *	       have been created as a result of the usual probe time SCMI
  *	       enumeration process.
+ * @des_nodes: An array to use as handy reference only to the set of nodes
+ *	       representing the DEs top directories.
  * @info: A handy reference to this instance SCMI Telemetry info data.
  *
  * The most notable field in this structure is the @all_nodes array, which
@@ -208,6 +210,7 @@ struct scmi_tlm_instance {
 	int max_nodes;
 	int num_nodes;
 	struct scmi_tlm_inode **all_nodes;
+	struct scmi_tlm_inode **des_nodes;
 	const struct scmi_telemetry_info *info;
 };
 
@@ -216,6 +219,526 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 
 static LIST_HEAD(scmi_telemetry_instances);
 
+#define TYPES_ARRAY_SZ		256
+
+static const char *compo_types[TYPES_ARRAY_SZ] = {
+	"unspec",
+	"cpu",
+	"cluster",
+	"gpu",
+	"npu",
+	"interconnnect",
+	"mem_cntrl",
+	"l1_cache",
+	"l2_cache",
+	"l3_cache",
+	"ll_cache",
+	"sys_cache",
+	"disp_cntrl",
+	"ipu",
+	"chiplet",
+	"package",
+	"soc",
+	"system",
+	"smcu",
+	"accel",
+	"battery",
+	"charger",
+	"pmic",
+	"board",
+	"memory",
+	"periph",
+	"periph_subc",
+	"lid",
+	"display",
+	"res_29",
+	"res_30",
+	"res_31",
+	"res_32",
+	"res_33",
+	"res_34",
+	"res_35",
+	"res_36",
+	"res_37",
+	"res_38",
+	"res_39",
+	"res_40",
+	"res_41",
+	"res_42",
+	"res_43",
+	"res_44",
+	"res_45",
+	"res_46",
+	"res_47",
+	"res_48",
+	"res_49",
+	"res_50",
+	"res_51",
+	"res_52",
+	"res_53",
+	"res_54",
+	"res_55",
+	"res_56",
+	"res_57",
+	"res_58",
+	"res_59",
+	"res_60",
+	"res_61",
+	"res_62",
+	"res_63",
+	"res_64",
+	"res_65",
+	"res_66",
+	"res_67",
+	"res_68",
+	"res_69",
+	"res_70",
+	"res_71",
+	"res_72",
+	"res_73",
+	"res_74",
+	"res_75",
+	"res_76",
+	"res_77",
+	"res_78",
+	"res_79",
+	"res_80",
+	"res_81",
+	"res_82",
+	"res_83",
+	"res_84",
+	"res_85",
+	"res_86",
+	"res_87",
+	"res_88",
+	"res_89",
+	"res_90",
+	"res_91",
+	"res_92",
+	"res_93",
+	"res_94",
+	"res_95",
+	"res_96",
+	"res_97",
+	"res_98",
+	"res_99",
+	"res_100",
+	"res_101",
+	"res_102",
+	"res_103",
+	"res_104",
+	"res_105",
+	"res_106",
+	"res_107",
+	"res_108",
+	"res_109",
+	"res_110",
+	"res_111",
+	"res_112",
+	"res_113",
+	"res_114",
+	"res_115",
+	"res_116",
+	"res_117",
+	"res_118",
+	"res_119",
+	"res_120",
+	"res_121",
+	"res_122",
+	"res_123",
+	"res_124",
+	"res_125",
+	"res_126",
+	"res_127",
+	"res_128",
+	"res_129",
+	"res_130",
+	"res_131",
+	"res_132",
+	"res_133",
+	"res_134",
+	"res_135",
+	"res_136",
+	"res_137",
+	"res_138",
+	"res_139",
+	"res_140",
+	"res_141",
+	"res_142",
+	"res_143",
+	"res_144",
+	"res_145",
+	"res_146",
+	"res_147",
+	"res_148",
+	"res_149",
+	"res_150",
+	"res_151",
+	"res_152",
+	"res_153",
+	"res_154",
+	"res_155",
+	"res_156",
+	"res_157",
+	"res_158",
+	"res_159",
+	"res_160",
+	"res_161",
+	"res_162",
+	"res_163",
+	"res_164",
+	"res_165",
+	"res_166",
+	"res_167",
+	"res_168",
+	"res_169",
+	"res_170",
+	"res_171",
+	"res_172",
+	"res_173",
+	"res_174",
+	"res_175",
+	"res_176",
+	"res_177",
+	"res_178",
+	"res_179",
+	"res_180",
+	"res_181",
+	"res_182",
+	"res_183",
+	"res_184",
+	"res_185",
+	"res_186",
+	"res_187",
+	"res_188",
+	"res_189",
+	"res_190",
+	"res_191",
+	"res_192",
+	"res_193",
+	"res_194",
+	"res_195",
+	"res_196",
+	"res_197",
+	"res_198",
+	"res_199",
+	"res_200",
+	"res_201",
+	"res_202",
+	"res_203",
+	"res_204",
+	"res_205",
+	"res_206",
+	"res_207",
+	"res_208",
+	"res_209",
+	"res_210",
+	"res_211",
+	"res_212",
+	"res_213",
+	"res_214",
+	"res_215",
+	"res_216",
+	"res_217",
+	"res_218",
+	"res_219",
+	"res_220",
+	"res_221",
+	"res_222",
+	"res_223",
+	"oem_224",
+	"oem_225",
+	"oem_226",
+	"oem_227",
+	"oem_228",
+	"oem_229",
+	"oem_230",
+	"oem_231",
+	"oem_232",
+	"oem_233",
+	"oem_234",
+	"oem_235",
+	"oem_236",
+	"oem_237",
+	"oem_238",
+	"oem_239",
+	"oem_240",
+	"oem_241",
+	"oem_242",
+	"oem_243",
+	"oem_244",
+	"oem_245",
+	"oem_246",
+	"oem_247",
+	"oem_248",
+	"oem_249",
+	"oem_250",
+	"oem_251",
+	"oem_252",
+	"oem_253",
+	"oem_254",
+	"oem_255",
+};
+
+static const char *unit_types[TYPES_ARRAY_SZ] = {
+	"none",
+	"unspec",
+	"celsius",
+	"fahrenheit",
+	"kelvin",
+	"volts",
+	"amps",
+	"watts",
+	"joules",
+	"coulombs",
+	"va",
+	"nits",
+	"lumens",
+	"lux",
+	"candelas",
+	"kpa",
+	"psi",
+	"newtons",
+	"cfm",
+	"rpm",
+	"hertz",
+	"seconds",
+	"minutes",
+	"hours",
+	"days",
+	"weeks",
+	"mils",
+	"inches",
+	"feet",
+	"cubic_inches",
+	"cubic_feet",
+	"meters",
+	"cubic_centimeters",
+	"cubic_meters",
+	"liters",
+	"fluid_ounces",
+	"radians",
+	"steradians",
+	"revolutions",
+	"cycles",
+	"gravities",
+	"ounces",
+	"pounds",
+	"foot_pounds",
+	"ounce_inches",
+	"gauss",
+	"gilberts",
+	"henries",
+	"farads",
+	"ohms",
+	"siemens",
+	"moles",
+	"becquerels",
+	"ppm",
+	"decibels",
+	"dba",
+	"dbc",
+	"grays",
+	"sieverts",
+	"color_temp_kelvin",
+	"bits",
+	"bytes",
+	"words",
+	"dwords",
+	"qwords",
+	"percentage",
+	"pascals",
+	"counts",
+	"grams",
+	"newton_meters",
+	"hits",
+	"misses",
+	"retries",
+	"overruns",
+	"underruns",
+	"collisions",
+	"packets",
+	"messages",
+	"chars",
+	"errors",
+	"corrected_err",
+	"uncorrectable_err",
+	"square_mils",
+	"square_inches",
+	"square_feet",
+	"square_centimeters",
+	"square_meters",
+	"radians_per_secs",
+	"beats_per_minute",
+	"meters_per_secs_squared",
+	"meters_per_secs",
+	"cubic_meter_per_secs",
+	"millimeters_mercury",
+	"radians_per_secs_squared",
+	"state",
+	"bps",
+	"res_96",
+	"res_97",
+	"res_98",
+	"res_99",
+	"res_100",
+	"res_101",
+	"res_102",
+	"res_103",
+	"res_104",
+	"res_105",
+	"res_106",
+	"res_107",
+	"res_108",
+	"res_109",
+	"res_110",
+	"res_111",
+	"res_112",
+	"res_113",
+	"res_114",
+	"res_115",
+	"res_116",
+	"res_117",
+	"res_118",
+	"res_119",
+	"res_120",
+	"res_121",
+	"res_122",
+	"res_123",
+	"res_124",
+	"res_125",
+	"res_126",
+	"res_127",
+	"res_128",
+	"res_129",
+	"res_130",
+	"res_131",
+	"res_132",
+	"res_133",
+	"res_134",
+	"res_135",
+	"res_136",
+	"res_137",
+	"res_138",
+	"res_139",
+	"res_140",
+	"res_141",
+	"res_142",
+	"res_143",
+	"res_144",
+	"res_145",
+	"res_146",
+	"res_147",
+	"res_148",
+	"res_149",
+	"res_150",
+	"res_151",
+	"res_152",
+	"res_153",
+	"res_154",
+	"res_155",
+	"res_156",
+	"res_157",
+	"res_158",
+	"res_159",
+	"res_160",
+	"res_161",
+	"res_162",
+	"res_163",
+	"res_164",
+	"res_165",
+	"res_166",
+	"res_167",
+	"res_168",
+	"res_169",
+	"res_170",
+	"res_171",
+	"res_172",
+	"res_173",
+	"res_174",
+	"res_175",
+	"res_176",
+	"res_177",
+	"res_178",
+	"res_179",
+	"res_180",
+	"res_181",
+	"res_182",
+	"res_183",
+	"res_184",
+	"res_185",
+	"res_186",
+	"res_187",
+	"res_188",
+	"res_189",
+	"res_190",
+	"res_191",
+	"res_192",
+	"res_193",
+	"res_194",
+	"res_195",
+	"res_196",
+	"res_197",
+	"res_198",
+	"res_199",
+	"res_200",
+	"res_201",
+	"res_202",
+	"res_203",
+	"res_204",
+	"res_205",
+	"res_206",
+	"res_207",
+	"res_208",
+	"res_209",
+	"res_210",
+	"res_211",
+	"res_212",
+	"res_213",
+	"res_214",
+	"res_215",
+	"res_216",
+	"res_217",
+	"res_218",
+	"res_219",
+	"res_220",
+	"res_221",
+	"res_222",
+	"res_223",
+	"res_224",
+	"res_225",
+	"res_226",
+	"res_227",
+	"res_228",
+	"res_229",
+	"res_230",
+	"res_231",
+	"res_232",
+	"res_233",
+	"res_234",
+	"res_235",
+	"res_236",
+	"res_237",
+	"res_238",
+	"res_239",
+	"res_240",
+	"res_241",
+	"res_242",
+	"res_243",
+	"res_244",
+	"res_245",
+	"res_246",
+	"res_247",
+	"res_248",
+	"res_249",
+	"res_250",
+	"res_251",
+	"res_252",
+	"res_253",
+	"res_254",
+	"oem_unit",
+};
+
 static inline int
 __scmi_tlm_generic_open(struct inode *ino, struct file *filp,
 			int (*bulk_op)(const struct scmi_tlm_setup *tsp,
@@ -753,6 +1276,10 @@ static int scmi_telemetry_des_initialize(struct device *dev,
 	struct scmi_tlm_inode *des_top_inode;
 
 	des_top_inode = TLM_INODE_SETUP(ti, tsp, &des_dir_cls, NULL, NULL);
+	ti->des_nodes = devm_kcalloc(dev, ti->info->base.num_des,
+				     sizeof(*ti->des_nodes), GFP_KERNEL);
+	if (!ti->des_nodes)
+		return -ENOMEM;
 
 	for (int i = 0; i < ti->info->base.num_des; i++) {
 		const struct scmi_telemetry_de *de = ti->info->des[i];
@@ -796,6 +1323,8 @@ static int scmi_telemetry_des_initialize(struct device *dev,
 				&dei->persistent);
 
 		TLM_INODE_SETUP(ti, tsp, &value_tlmo, de_dir_inode, de);
+
+		ti->des_nodes[i] = de_dir_inode;
 	}
 
 	dev_info(dev, "Found %d Telemetry DE resources.\n", ti->info->base.num_des);
@@ -1633,10 +2162,204 @@ scmi_tlm_node_add(struct super_block *sb, struct dentry *parent,
 	return dentry;
 }
 
+static struct inode *scmi_telemetry_make_dir_inode(struct super_block *sb)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino = get_next_ino();
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, S_IFDIR | 0700);
+	simple_inode_init_ts(inode);
+
+	inode->i_op = &tlm_dir_inode_ops;
+	inode->i_fop = &simple_dir_operations;
+
+	return inode;
+}
+
+static struct dentry *scmi_telemetry_topology_dir_alloc(struct super_block *sb,
+							struct dentry *parent,
+							const char *name)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	inode = scmi_telemetry_make_dir_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
+	d_add(dentry, inode);
+
+	dget(dentry);
+
+	return dentry;
+}
+
+static struct scmi_tlm_inode *
+scmi_telemetry_de_subdir_clone(struct super_block *sb,
+			       struct scmi_tlm_inode *tlmi,
+			       struct dentry *parent)
+{
+	struct device *dev = tlmi->tsp->dev;
+	struct scmi_tlm_inode *dtlmi;
+	struct dentry *twin, *child;
+	struct qstr qstr;
+
+	/*
+	 * NOTE THAT I CANNOT HARD-LINK A DIRECTORY ... BREAKS VFS
+	 * ...so we just duplicate the tlm_inode here
+	 */
+	dtlmi = devm_kmemdup(dev, tlmi, sizeof(*tlmi), GFP_KERNEL);
+	if (!dtlmi)
+		return ERR_PTR(-ENOMEM);
+
+	qstr.name = dtlmi->cls->name;
+	qstr.len = strlen(dtlmi->cls->name);
+	qstr.hash = full_name_hash(parent, qstr.name, qstr.len);
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N/<DE_UNIT_TYPE_STR>/<M>/<DE_ID> */
+	twin = d_lookup(parent, &qstr);
+	if (twin) {
+		dev_err(dev, "Found duplicated entry '%s' in topology.\n",
+			dtlmi->cls->name);
+		return ERR_PTR(-EBUSY);
+	}
+
+	twin = d_alloc_name(parent, dtlmi->cls->name);
+	if (!twin)
+		return ERR_PTR(-ENOMEM);
+
+	dtlmi->dentry = twin;
+	dtlmi->parent = NULL;
+	if (!scmi_tlm_inode_initialize(sb, S_IFDIR | dtlmi->cls->mode, dtlmi))
+		return ERR_PTR(-ENOMEM);
+
+	/* Add another dentry to the duplicated inode under another parent */
+	d_add(twin, &dtlmi->vfs_inode);
+
+	/* Hard-link all child of tlmi to the duplicate */
+	spin_lock(&tlmi->dentry->d_parent->d_lock);
+	hlist_for_each_entry(child, &tlmi->dentry->d_children, d_sib) {
+		struct dentry *hdl;
+
+		if (!child->d_inode)
+			continue;
+
+		hdl = d_alloc_name(twin, child->d_name.name);
+		if (!hdl) {
+			spin_unlock(&tlmi->dentry->d_parent->d_lock);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		inode_inc_link_count(child->d_inode);
+		d_add(hdl, child->d_inode);
+	}
+	spin_unlock(&tlmi->dentry->d_parent->d_lock);
+
+	return 0;
+}
+
+static struct dentry *
+scmi_telemetry_topology_path_get(struct super_block *sb, struct dentry *parent,
+				 const char *dname)
+{
+	struct dentry *dentry;
+	struct qstr qstr;
+
+	qstr.name = dname;
+	qstr.len = strlen(dname);
+	qstr.hash = full_name_hash(parent, qstr.name, qstr.len);
+
+	dentry = d_lookup(parent, &qstr);
+	if (!dentry) {
+		dentry = scmi_telemetry_topology_dir_alloc(sb, parent, dname);
+		if (!dentry)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return dentry;
+}
+
+static int scmi_telemetry_topology_add_node(struct super_block *sb,
+					    struct dentry *top_dentry,
+					    struct scmi_tlm_inode *tlmi)
+{
+	struct dentry *ctype, *cinst, *cunit, *dinst;
+	const struct scmi_telemetry_de *de = tlmi->priv;
+	struct scmi_tlm_de_info *dei = de->info;
+	struct scmi_tlm_inode *dtlmi;
+	char inst_str[32];
+
+	/* by_compo_type/<COMPO_TYPE_STR>/ */
+	ctype = scmi_telemetry_topology_path_get(sb, top_dentry,
+						 compo_types[dei->compo_type]);
+	if (!ctype)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/ */
+	snprintf(inst_str, 32, "%u", dei->compo_instance_id);
+	cinst = scmi_telemetry_topology_path_get(sb, ctype, inst_str);
+	dput(ctype);
+	if (!cinst)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/<DE_UNIT_TYPE_STR>/ */
+	cunit = scmi_telemetry_topology_path_get(sb, cinst,
+						 unit_types[dei->unit]);
+	dput(cinst);
+	if (!cunit)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/<DE_UNIT_TYPE_STR>/<N> */
+	snprintf(inst_str, 32, "%u", dei->instance_id);
+	dinst = scmi_telemetry_topology_path_get(sb, cunit, inst_str);
+	dput(cunit);
+	if (!dinst)
+		return -ENOMEM;
+
+	dtlmi = scmi_telemetry_de_subdir_clone(sb, tlmi, dinst);
+	dput(dinst);
+
+	return PTR_ERR(dtlmi);
+}
+
+static int scmi_telemetry_topology_view_add(struct super_block *sb,
+					    struct scmi_tlm_instance *ti)
+{
+	struct device *dev = ti->tsp->dev;
+	struct dentry *topo;
+
+	topo = scmi_telemetry_topology_dir_alloc(sb, ti->top_inode->dentry,
+						 "components");
+	if (!topo)
+		return -ENOMEM;
+
+	for (int i = 0; i < ti->info->base.num_des; i++) {
+		int ret;
+
+		ret = scmi_telemetry_topology_add_node(sb, topo,
+						       ti->des_nodes[i]);
+		if (ret)
+			dev_err(dev, "Fail to add node %s to topology. Skip.\n",
+				ti->des_nodes[i]->cls->name);
+	}
+
+	dput(topo);
+
+	return 0;
+}
+
 static int scmi_telemetry_instance_register(struct super_block *sb,
 					    struct scmi_tlm_instance *ti)
 {
 	struct dentry *top;
+	int ret;
 
 	/* AT first create instance top dir ... */
 	top = scmi_tlm_node_add(sb, sb->s_root, ti->top_cls.name,
@@ -1664,6 +2387,13 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 			return PTR_ERR(dentry);
 	}
 
+	/* Add an alternative topological view for the DES nodes */
+	ret = scmi_telemetry_topology_view_add(sb, ti);
+	if (ret)
+		dev_warn(ti->tsp->dev,
+			 "Failed to create topology view for instance %s.\n",
+			 ti->top_cls.name);
+
 	return 0;
 }
 
-- 
2.51.0


