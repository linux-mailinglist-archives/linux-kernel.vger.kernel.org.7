Return-Path: <linux-kernel+bounces-792880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C7B3C9FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712841C232DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B126E6EB;
	Sat, 30 Aug 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUD74xTG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA226D4D4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548864; cv=none; b=KOgZvq4cnfLw0ZUTIudAj+SGGRlGRphe79+JWkzo9ykTfdJ0WAXdtBmBigO7gVae6dXl458iZ5SCCONTqwVeq73re3OJF1QZPWTlLrcwvRmjTFs2qb/nyg6wnHuBXIwe8oaZTC5DUGmJSnEpka+L8B2apH3d4GGuJSCkJeSwK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548864; c=relaxed/simple;
	bh=IaL7ajgEckNEFeptbQZHtaF473l87dF48nSdgY/pR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXUAb3yJfVA1CMR072/kVLsgJgjI1xdvyLNdQHCA5NjOLj7KwpwgO/SonL4Ki5GZojD8Hb6baD30LTQL6UaeJhD9wrRQEhH2zlgaALvxmi6dGAe3OhMg2dsSG4ozu6Q67x7NXMB4gTE0gBxTyFxhTrYaIG9EzpIm4gn+7z5kbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUD74xTG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cef6debedcso1023346f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548861; x=1757153661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xoi0shITNqEF4SWAsgTXmAWKuaQLzQyyqW+Hmtl3ZaA=;
        b=jUD74xTGixmaDnp/HKmJAD20d9XPzqt61KB+cEA73xEqOySL6GvvLKU96sdjgXZtvG
         4siHT+sTxZuagqEC1xRVRMdkfaAmEj3RkXK6mgPeeysgMNZyluiRoid45N6maNfWKcsJ
         aWidkA9hTxAJ+si2d4y0O7TSJ1qaYUufv/jEAmFuSpqwTOVDPF4j79E5dTws+lWq30Qx
         Yz8Qp64/QUKirmKo1Ux8sXN7IGtyWR1xRGTdVivwsxJiLAAyiYILgtny3Nen9bFzoUgi
         UicpGYH+o04mMdLMIEQCpDUmZPe1SISorn4TmgPHxeeji9kZ0WNzhq7kBYoDLEzeucm+
         ED0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548861; x=1757153661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xoi0shITNqEF4SWAsgTXmAWKuaQLzQyyqW+Hmtl3ZaA=;
        b=g1HtnuEnuw6NUvgILa+03npWbW/yRCw/j5X+4l9r6pYH6/a+fiO+voc8UhXcm4gHmC
         XBSSR97mhu768XAgEYLfEa8tufKNVqqKV/NKhGFE/ElcAAdeG+erbLpyint07pb99MQS
         AgmrYI8zmbmrm8IL0n5sImCYg9137/LtzmvzEXDstyrut3FgCl3zyNw9o7y0AGkwlMWo
         QHsotZ5U5eNViSmduELkXMMk++Stkk2dRat7m3zr4enB/2lgUEM35QfPMVsK6/m8N4/i
         adL1GgJtSVHUL23OfPA6uIJ+2f7X81k8Lq4aaoS2VGyAouL/PIsXiRNx1iPxF2Bc6/mm
         Ny3A==
X-Gm-Message-State: AOJu0Ywcph4vwWFneRZFr6o2NbcIsjwgipMKKfLhgZfCQ9bDwxiPi9nO
	EzQKb+gr5ZDbB8nq33QLa01VL72ByaukSNURZXK4ZJ1gzHhL8T1HDOOoyV7l1Q4QuY8F5Q==
X-Gm-Gg: ASbGnct6pibvT0gCaFCCBi/Hof8Xx20xALjkwtqLs0UtAGuHyPg/YB2VkTIAXl56Pkj
	0GZP5xRxAhskvdTots7pTsNX4PIFDLxB3OrG8FibWS9/3yOCssFA5ZUtDueD2VRWdNO9/3cdotR
	P7fOR47J3CbcBdeb11VfHyn658Gl/ba4fD34xRFnFDFhCZJ/0X2Uv7E4v7FOEQGT/OYjApqFNPm
	Phrd5268K02INuvl/2YaFBqLPerxoCInPC8LgVcEkd9YCd9AlLgUnqurq6ROdEWyA+X39YamNnH
	Bvt75U6EcaExIUosBQVGlYYY8+MXQiYJNgVgKHTDx2KbQAjb4TxBzK6dhOcDMdKOLStQn2VWLRk
	GyQMqvV9UTi+kGA6pW8ELauGof68pdgUivEXbj6zE0PLSJ3ZxEZc9y3jdNpPvTPQiRp/a4KHEDb
	w5H1S8K06LkwFDa22OCBc3bgHWgE6X0qurohQ4lwKIOyA16U8BezDnXWI/Jgd6zv4SHaPL1aPw3
	IH7AGtG
X-Google-Smtp-Source: AGHT+IHZG6uR9ABulgPhzv60+mohxqvIwSU0wLSEKcNLkRxduymyoeRrKvrt+4O+1/32VjFe9kczrQ==
X-Received: by 2002:a05:6000:144e:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3d1dcf57b4fmr1083916f8f.26.1756548861272;
        Sat, 30 Aug 2025 03:14:21 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 02/12] refactor: handle cases from_dir and from_other in find_rsb_nodir
Date: Sat, 30 Aug 2025 12:14:03 +0200
Message-ID: <20250830101413.602637-2-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
References: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 5af1840f98d8..0165b3b7e36a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1007,16 +1007,54 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 * rsb not found
 	 */
 
+	if (error == -EBADR && !create)
+		goto out;
+
 	error = get_rsb_struct(ls, name, len, &r);
 	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
 	r->res_dir_nodeid = dir_nodeid;
-	r->res_master_nodeid = dir_nodeid;
-	r->res_nodeid = (dir_nodeid == our_nodeid) ? 0 : dir_nodeid;
 	kref_init(&r->res_ref);
 
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
+
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
+
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
+
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
+	}
+
+ out_add:
+
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
 	if (error == -EEXIST) {
-- 
2.48.1


