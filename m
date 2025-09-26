Return-Path: <linux-kernel+bounces-834208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27DBA4308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAF774092C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9E223328;
	Fri, 26 Sep 2025 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da8R3hVJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8550222564
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896531; cv=none; b=qK1naSXgmByMNAbRZItPbsYE2RDtyAfzIlsU4kZnjViS5qNmQ1dA3c++u5XUtl6/Vf0UBUK1gLi+tIjb/ZnM8NiDRbg8s2mTKH0KRsJglM354xHUtpWGhrFyHIpb+D8XRNrAK3Rvh4gQNsnXBGreWysfvSg2cgp7eSQZRYaXrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896531; c=relaxed/simple;
	bh=N3kFOI7Q94vKehPgwtOdCjbRO2v4wzqyv78VeTqmyJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii22zd5eis72ACZE9Gz33aD43u7fpTn6Q5K192nVqtz43+lrN7pNtVH5kyqxgYxdXkYJXDYw2VZnBccKJvUPGFOu8gyTTMjsB5Qkc6Ybi3oD5qT0XVIHXUlZqGHDudDEaG7VsTXE0t9QTnirLoq1sjCu+Z6bUq4OaSRmUUrt0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da8R3hVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8W0nMn8gRosNUqrDUZny5UWlLrt4l0mKD/5kYIWbhk=;
	b=Da8R3hVJ0nrZLXt8WL6wDPmI8Ih+JmQWvVSPeSd5G77Cu3BaJJHfjS5bynirxp4ngbkGsd
	8BwyafSmHEzes78hT1UfKXfLc1opOPgv0Lsqg6Mwn/9MxlszImUP564fGd54aTco5YZvUM
	L4TSgaR1EubbpxxbtXf4i+PVW+BZ2OY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-pBm42MfMNHm4v6ubD8bt-Q-1; Fri,
 26 Sep 2025 10:22:02 -0400
X-MC-Unique: pBm42MfMNHm4v6ubD8bt-Q-1
X-Mimecast-MFC-AGG-ID: pBm42MfMNHm4v6ubD8bt-Q_1758896520
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DE7D19774E5;
	Fri, 26 Sep 2025 14:22:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1346730001B7;
	Fri, 26 Sep 2025 14:21:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 2/3] dpll: add phase_offset_avg_factor_get/set callback ops
Date: Fri, 26 Sep 2025 16:21:39 +0200
Message-ID: <20250926142140.691592-3-ivecera@redhat.com>
In-Reply-To: <20250926142140.691592-1-ivecera@redhat.com>
References: <20250926142140.691592-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add new callback operations for a dpll device:
- phase_offset_avg_factor_get(...) - to obtain current phase offset
  averaging factor from dpll device,
- phase_offset_avg_factor_set(...) - to set phase offset averaging factor

Obtain the factor value using the get callback and provide it to the user
if the device driver implements callbacks. Execute the set callback upon
user requests.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 76 +++++++++++++++++++++++++++++++++----
 include/linux/dpll.h        |  6 +++
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 0a852011653c4..55b3ffe08024b 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -164,6 +164,28 @@ dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
+				     struct dpll_device *dpll,
+				     struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 factor;
+	int ret;
+
+	if (ops->phase_offset_avg_factor_set &&
+	    ops->phase_offset_avg_factor_get) {
+		ret = ops->phase_offset_avg_factor_get(dpll, dpll_priv(dpll),
+						       &factor, extack);
+		if (ret)
+			return ret;
+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_AVG_FACTOR, factor))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
 static int
 dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
@@ -675,6 +697,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
 	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_phase_offset_avg_factor(msg, dpll, extack);
 	if (ret)
 		return ret;
 
@@ -839,6 +864,32 @@ dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
 					     extack);
 }
 
+static int
+dpll_phase_offset_avg_factor_set(struct dpll_device *dpll, struct nlattr *a,
+				 struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	u32 factor = nla_get_u32(a), old_factor;
+	int ret;
+
+	if (!(ops->phase_offset_avg_factor_set &&
+	      ops->phase_offset_avg_factor_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of phase offset averaging");
+		return -EOPNOTSUPP;
+	}
+	ret = ops->phase_offset_avg_factor_get(dpll, dpll_priv(dpll),
+					       &old_factor, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current phase offset averaging factor");
+		return ret;
+	}
+	if (factor == old_factor)
+		return 0;
+
+	return ops->phase_offset_avg_factor_set(dpll, dpll_priv(dpll), factor,
+						extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1736,14 +1787,25 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
 static int
 dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
 {
-	int ret;
-
-	if (info->attrs[DPLL_A_PHASE_OFFSET_MONITOR]) {
-		struct nlattr *a = info->attrs[DPLL_A_PHASE_OFFSET_MONITOR];
+	struct nlattr *a;
+	int rem, ret;
 
-		ret = dpll_phase_offset_monitor_set(dpll, a, info->extack);
-		if (ret)
-			return ret;
+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(a)) {
+		case DPLL_A_PHASE_OFFSET_MONITOR:
+			ret = dpll_phase_offset_monitor_set(dpll, a,
+							    info->extack);
+			if (ret)
+				return ret;
+			break;
+		case DPLL_A_PHASE_OFFSET_AVG_FACTOR:
+			ret = dpll_phase_offset_avg_factor_set(dpll, a,
+							       info->extack);
+			if (ret)
+				return ret;
+			break;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index fa1e76920d0ee..25be745bf41f1 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -38,6 +38,12 @@ struct dpll_device_ops {
 					void *dpll_priv,
 					enum dpll_feature_state *state,
 					struct netlink_ext_ack *extack);
+	int (*phase_offset_avg_factor_set)(const struct dpll_device *dpll,
+					   void *dpll_priv, u32 factor,
+					   struct netlink_ext_ack *extack);
+	int (*phase_offset_avg_factor_get)(const struct dpll_device *dpll,
+					   void *dpll_priv, u32 *factor,
+					   struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
-- 
2.49.1


