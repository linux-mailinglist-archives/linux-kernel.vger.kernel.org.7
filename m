Return-Path: <linux-kernel+bounces-814676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F582B5572B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595AC568456
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5388340DB3;
	Fri, 12 Sep 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjxY9xfs"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A93375AB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706845; cv=none; b=bGZGQKloh+AQWvGoizmSMYYKDtDPvwTPxJKlLFvobLq3Y1FSWg/yqBU3ZdYzPvkZkGNHWicjG/iIF4wrKJoXth9TBJShQX50BPstcj1TbuFD2s/l5/qcPPixVkR3/+w21LKALJ2lE0qfhe5icecd7EvSVDqLk17yxl4b6QzzjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706845; c=relaxed/simple;
	bh=vtDr/kO1KchOCd5UEjGrTzcH3EcLOyUzNxhEjmZWIks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjm035nGjQ6B2Y43dp/wW5Ylub00zAPz7xSxdZ6sHpiTj8zymRcIru+o9OI3KJHRH/Ln/rvWnNxPiFeLqt2PoArvCct23rkdtfmHdyD0pIX9S164Y+6APociXQyUsQpS8QnfpPjf1LlvG7AImCpdMFUZre9X82+na7xSml5gXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjxY9xfs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso16434255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706842; x=1758311642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMaCvv0Npwgx9oOEe08/7S4E7IejpQl1+Xgtp1j/Fs0=;
        b=DjxY9xfsTYSWk4yR99ILE8xz3o2YSg36NeLT/0A2zoMV3EWUuOrsgn1WIyXCR6ANPo
         UYyLI6YmX1CE6xVed3nBQyAt0A6is/FMJ/Q5g/DEJDDoMmkEkPdijK+A0J0q7OBB4rwz
         ao0Ubnqb49/zIRFbcuJGVOvYy0AIXEeQ06wEQCJaNHDQswIy0JICDIZLzwlh58zNmNkS
         KBj5/TlTzGm79+LWErw8FPdnSzmR2MWhRJiosaZh/CryQAfQfMYf4wLsObNr40kdOsrT
         C+RrSBMBvYu7A3ZT8o70mVOUP8W0JK9FHpS1HXmQwaIawQXHynkVc+tBUjGxuZNMrrv5
         6x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706842; x=1758311642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMaCvv0Npwgx9oOEe08/7S4E7IejpQl1+Xgtp1j/Fs0=;
        b=c3EClZOju1vOrRMo5FdCtnU3oC0+1/Qf4TKW87OJN5SAfs3IvuAZCykw+H2kZkTxXt
         Sc7k5XhaRyG4qNHUEFvuYGpI2NDaSAd6oE272w+sJKAdt59h2ib2pMaAcv72NbMSbU9i
         xIT+4F6V3UetYajv1+0tX98q4UxyT9KqbDUF+kxYTGgK0dXekMC7IiagmSPdJ/V2UtP/
         E+565TpYfXZfRh7wOQh/Z79NI9UzQ6i1H+LKnr3khBcfYY9TyDSz9Ogmsc4VcLMgxlcq
         VTLbPgyRebxbEEWDt6pSTKcc3cQjn+xNTFtValKklTAOE8dGxO54Wi5CiR6VEDVuHZvd
         ixbg==
X-Forwarded-Encrypted: i=1; AJvYcCUwQnc3DZfJctwLheRAOvCSebc9+Skjo7RxSelbICPGyhFENLlQEQE+JZ2ocKCmzZaqVgIAg4CYrPzQx0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkJfQtDbMEe3t9M2YSbmuYSrMB3htiVpR/lQXc2b9uN+nDftV
	T6mC/3mRpeSPdtWAoAzzF2Cli5AejBiVCdqLB1bJWTiK1f0CvIlK3gTu
X-Gm-Gg: ASbGncvbcnEiDbQ5/sF+5Gl79URw3fpGhBh3jPgxZsAjP8Fpg2NNVnakFYE6G81io3Y
	7vCXhQ7J3ZMarGUHaarvalxLm0oJlr5yfzpt4H/psW5Xr5EtigFsi4kNskVVCNJ7bjnufTueoKC
	lsTvAdUeLippWV1joAFGz21ePXB7BL4nVqlEBEmWmyKDq8A2qI8vk9mBDpBP9qp2GCcAanCT9lg
	LdXdOn3AE+1eD/jvl0qUUzyeTFBY5Aqjws15h5BBZOAGzAHJNloAubd8qnWuhPRwX+1A02trB5p
	VYTPzk5QlbK02yDBc6w+txiLE8Kd3RyIfth/mMY0ea0IdvhWuZ+vZhqKUsBJIWYDXwVU3m3vo4F
	iSyJoh9uUuoy5c11vil08CpWzUbryfR3Iat7AmSb+r//PxXGWZPHMqFt6RrvEVDwkiqujHIas
X-Google-Smtp-Source: AGHT+IHOezLJRLoDEw/gyTNCxGzG6tpMAlxv09ll/ErrKIIhPmloNLfh1ZLyplu0Cr/e++Aufdl6nA==
X-Received: by 2002:a05:6000:178e:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e765a53ca5mr3716925f8f.63.1757706842098;
        Fri, 12 Sep 2025 12:54:02 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:01 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 07/15] genetlink: add THIRD_GENL family
Date: Fri, 12 Sep 2025 22:53:30 +0300
Message-Id: <20250912195339.20635-8-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- New family with echo command
- Supports string and flag attributes
- Sysfs interface at /sys/kernel/third_genl/message

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index cdedd77b2a1b..f651159a311c 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -152,10 +152,13 @@ static DEFINE_MUTEX(genl_mutex);
 
 #define PARALLEL_GENL_FAMILY_NAME "PARALLEL_GENL"
 
+#define THIRD_GENL_FAMILY_NAME "THIRD_GENL"
+
 #define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
 #define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
 #define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
 #define PATH_PARALLEL_GENL_MES "/sys/kernel/parallel_genl/message"
+#define PATH_THIRD_GENL_MES "/sys/kernel/third_genl/message"
 
 // TEST_GENL
 enum {
@@ -205,6 +208,8 @@ static struct genl_family my_genl_family;
 
 static struct genl_family my_genl_family_parallel;
 
+static struct genl_family third_genl_family;
+
 enum my_multicast_groups {
 	MY_MCGRP_GENL,
 };
@@ -1077,6 +1082,94 @@ static struct genl_family my_genl_family_parallel = {
 	.n_mcgrps = ARRAY_SIZE(genl_many_mcgrps_two),
 };
 
+// THIRD_GENL
+enum {
+	THIRD_GENL_ATTR_UNSPEC,
+	THIRD_GENL_ATTR_DATA,
+	THIRD_GENL_ATTR_FLAG,
+	__THIRD_GENL_ATTR_MAX,
+};
+
+#define THIRD_GENL_ATTR_MAX (__THIRD_GENL_ATTR_MAX - 1)
+
+enum {
+	THIRD_GENL_CMD_UNSPEC,
+	THIRD_GENL_CMD_ECHO,
+	__THIRD_GENL_CMD_MAX,
+};
+
+#define THIRD_GENL_CMD_MAX (__THIRD_GENL_CMD_MAX - 1)
+
+static const struct nla_policy third_genl_policy[THIRD_GENL_ATTR_MAX + 1] = {
+	[THIRD_GENL_ATTR_UNSPEC] = { .type = NLA_UNSPEC },
+	[THIRD_GENL_ATTR_DATA] = { .type = NLA_STRING },
+	[THIRD_GENL_ATTR_FLAG] = { .type = NLA_FLAG },
+};
+
+// Functions for THIRD_GENL family
+static int third_genl_echo(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	void *data;
+	int ret;
+	char *str;
+
+	if (info->nlhdr->nlmsg_flags & NLM_F_ECHO) {
+		msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		data = genlmsg_put_reply(msg, info, &my_genl_family, 0,
+					 THIRD_GENL_CMD_ECHO);
+		if (!data)
+			goto error;
+
+		str = "Hello from THIRD_GENL!";
+		strcpy(sysfs_data.third_genl_message, str);
+
+		ret = nla_put_string(msg, THIRD_GENL_ATTR_DATA, str);
+		if (ret < 0)
+			goto error;
+
+		ret = nla_put_flag(msg, THIRD_GENL_ATTR_FLAG);
+		if (ret < 0)
+			goto error;
+
+		genlmsg_end(msg, data);
+
+		genlmsg_reply(msg, info);
+	}
+
+	return 0;
+
+error:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
+// Generic Netlink operations for THIRD_GENL family
+static const struct genl_ops third_genl_ops[] = {
+	{
+		.cmd = THIRD_GENL_CMD_ECHO,
+		.flags = 0,
+		.policy = third_genl_policy,
+		.doit = third_genl_echo,
+		.dumpit = NULL,
+	},
+};
+
+// genl_family struct for THIRD_GENL family
+static struct genl_family third_genl_family = {
+	.hdrsize = 0,
+	.name = THIRD_GENL_FAMILY_NAME,
+	.version = 1,
+	.maxattr = THIRD_GENL_ATTR_MAX,
+	.netnsok = true,
+	.ops = third_genl_ops,
+	.n_ops = ARRAY_SIZE(third_genl_ops),
+	.policy = third_genl_policy,
+};
+
 // genl_family struct with incorrect name
 static struct genl_family incorrect_genl_family = {
 	.hdrsize = 0,
@@ -1144,8 +1237,16 @@ static int __init init_netlink(void)
 		goto failure_2;
 	}
 
+	rc = genl_register_family(&third_genl_family);
+	if (rc) {
+		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
+		goto failure_3;
+	}
+
 	return 0;
 
+failure_3:
+	genl_unregister_family(&my_genl_family_parallel);
 failure_2:
 	genl_unregister_family(&my_genl_family);
 failure_1:
@@ -1311,6 +1412,7 @@ static int __init module_netlink_init(void)
 err_family:
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
+	genl_unregister_family(&third_genl_family);
 err_sysfs:
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
@@ -1330,6 +1432,7 @@ static void __exit module_netlink_exit(void)
 	netlink_unregister_notifier(&genl_notifier);
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
+	genl_unregister_family(&third_genl_family);
 
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
-- 
2.34.1


