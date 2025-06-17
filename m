Return-Path: <linux-kernel+bounces-689343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29096ADBFED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 05:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77211681DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 03:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14161F3BA9;
	Tue, 17 Jun 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FO3C1lS8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC821922FB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131369; cv=none; b=q1SMnskbAOSkDdQ2TCKdBWAacDC+TU+UdPS0QTEnCgVpsiJZFn5DgoLleg/mx7auYwZEPQhhKfelCh330Gk+2uXpG5CDYZTG5rrYludqwzCshWRYszpO13c0DSnDeIeEhrNu24S2JkV7x3VWjBkK/DOA2Sr5NxXRIeu5eK1hMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131369; c=relaxed/simple;
	bh=dQxkobsAclMg4B6C3oDqN3OjfKg7051DNhwLh4ZsfOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CJ/VzHGGBEKM6KkaERijVr3p4l6QzF5NU/ivm6bp1nz+INm/mpJT9x8ZVLGc7Nje/nTo58lzhQjff98b7CfQ5pBts9Ihkk+Ly2XnSFLtAr/xW13vwgPsZ04ip8+WxUNhy8eAxGO2pshL4a98mh2x0cJFlu2C/v+0RfZvGgNJxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FO3C1lS8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GI2um2005767
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 03:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SXaiysyC/M+/tDpGKqLEbi
	nKnxqzYegzIqQucICqSuk=; b=FO3C1lS8x/gja3snDKyAey/S7EZk3Y4I7V3Qn8
	SK7GcLHrkvVE9egepyeFKTRX7U4FIY7XVbYyDrKYMSxOYj+RPH0svVGFh+JyDOhe
	wnG3q1Sy6lUkohWROBWrEErCC9KsEON7Qk+WIzD1SKJH6fEtKPWedPqHevc1ACdK
	h16Jo/NSSQqgE4x8E83wYhbl/lSqHiQ4UqFHBEIzCPTBFfGRO6HlQFpSfwP1YuJC
	yE52MgDZNJZQxrIX5q4pdbpV30wyRX/SIglt/FCXfmgNjM8Y1XirbLFTgVwlCEz0
	X9Kj725JJgUtYKVm99tYo3/9BHIvOeQ9pO4zYZNtu52Ts/uw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcxq71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 03:36:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31831b0335so3426222a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 20:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750131365; x=1750736165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXaiysyC/M+/tDpGKqLEbinKnxqzYegzIqQucICqSuk=;
        b=WTPN4YSfN+tSnpkh5TyhEybM4iurF/vV0j4rwyoTQUjYiJ8/dde/0vM3U59tG9ezur
         sLTYSeNtlmKSbY4VfBccnRTYYfPoIITEEMKv0gmbX3xnymg1PTZSp3JtFlPK+3exoZWq
         i6H72YDWOJoYAItNFaE2UvsaYO+JhuYySDywS+8aL2zBTXp+7ekW84KlAQoOtld3+5jQ
         QgxTQm+K7dzeBIruZwC7g5sPgmby528qHYI1zioY8eiSqg4LTu9rOfAtVVZxUrfErE/a
         G1YJDAlJdjm5aMEJrZvhuq3x4GiT3f721ijZNREPMElIc5csLU3di+0uqsApOQzHvjUP
         JUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW54t60JhbHAfUYFjlrSsa6jKXxbrsbTnfubiD8B2/q5K2IzGdTSzwKsYBhE+7ngwQcoMGf6VS6JHri8Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsEfu8vQt3sarCce3hWsPGeZtRx67Dn7KqYyAbRi5jYlMaGoi
	XsvzIj9Ir0JsHNktpRNXbDDR8v2xsnPWBDJfUn7QZuWVtHbnUvfNRPYgRuqhC9rvQAFPm1ADGTl
	Vrk3FCP11/12VJjSq3LF9DMzvmxvuxtJx3orKXxEtr35yr/DtBQT8uNnnQb7OVqUrw8A=
X-Gm-Gg: ASbGnct/QuSTukwRj16Vd9CgSeifj+Xyvdk6xEGw5Tf/ZFzxYp/fcBg2PgJTe8z5cLO
	6NwmBaxZm68LgFPm2olmxqgSKlB0tfkg50uA3aen4kDifCI6YyjtSxdGN6YFx3gmy3iylgiEK9x
	XlOye9D6cZBShewv4FbaJtA34fstRF2dVmQLHOAf/u+jWp4aVCemxp6iqGzJDQGXjHPmUQdr9yB
	EMeuUDLrcIA4/Kv/jt4akVCjw3yuBWdTyacUeRV8qvYv33qRH5u+XUPqTPBeT558i3WG4RLqU6f
	pni3Wp6T+TvT0M1UukGRg3U139c2VPoYjeatJJlmbWxzvFDaKyKF4D7nydH46ttGMtodr9haTza
	VGyob/y5F4GaIwmUkMl8g0IulyRo+yxma+avTqNQ8XMSSAoE=
X-Received: by 2002:a17:90b:4e90:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-313f1c07f88mr20268768a91.14.1750131364616;
        Mon, 16 Jun 2025 20:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8F9gocBMZScl0mlUsjSwGe6dHuZffl7cW0gp2NR649XWeFN4k80zvim3Vf1qS+FoYNQ95Ew==
X-Received: by 2002:a17:90b:4e90:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-313f1c07f88mr20268699a91.14.1750131364049;
        Mon, 16 Jun 2025 20:36:04 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1fa0sm69273695ad.86.2025.06.16.20.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 20:36:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 09:05:59 +0530
Subject: [PATCH ath-next v2] wifi: ath12k: handle regulatory hints during
 mac registration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-handle_user_regd_update_hints_during_insmod-v2-1-10a6a48efe81@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJ7iUGgC/6WQwW7DIAyGX6XiPCogAZKd9h5ThWhsEqQGOkiiV
 lXefSSXHbYd1l0s2b/8f7/9IBmTx0xeDw+ScPHZx1Aa8XIg3WBDj9RD6YlgQjIpBC1DuKCZy55
 J2IOZr2AnNIMPUzYwJx9640MeI9BadJojalc1ihTHa0LnbzvtndhpoAFvEzkVZfB5ium+x1j4r
 j9FXDjltLHONiAr3bT2LeZ8/JjtpYvjeCxly7FbK/6EtdTqDMwpOCP7br1dsoh/pBcFUUNTO+Y
 k007/gqi+EIrzvyGq7UFtCxI7BNe6HxDrun4CJfPahRgCAAA=
X-Change-ID: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAyOSBTYWx0ZWRfX+PNwCLp9o20c
 Yz3fE6F9QCvG85r/UYOtVSBVoeK0dp/C/u9wpyD8YNklhfunfoqkCwPHdPRFJaUjtloBwaL0bVP
 I7AUfvy+bWTnShQAaa8m3ny0BbF0PGxVXXJfSH2PKAMuTgvKIie+5cvaXgpRsqjINcM8uIO5Lcv
 DjJwFGkdLm9vE9ezmTvTKADtG45XGd/TVCIKYE7zhLYAjMoTZBik6wtMaSkeIHpcfxMnDp1wZJj
 xCipQotu5poDl0jQ5btAIssVcGDPbxKEqV7R261FN8LOGSUHdVxdGOQuQa5atiVvRgDD86Gsbfs
 X1HO/H2Q3xVO+lqr9hEIrfWbMA8IdsKcqJlbX2eYfCH50Wp4YwkNvgB6r80mnqXXYrbOlkaDiDK
 DEMvccCo380ln8zil7F4jEEfHUH3fbBQeOxRh8Q5C5uBxWDY9keiyykT67Stdyd3wWRNUZpn
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=6850e2a5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=cjyl3gcxlCMcS8tmzmQA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: VJDFNd2dhIvHbpF_4-Jy8KGccpEG4UEA
X-Proofpoint-GUID: VJDFNd2dhIvHbpF_4-Jy8KGccpEG4UEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170029

If a regulatory notification is there in the system while the hardware is
being registered, it attempts to set the new regulatory country. However,
ath12k currently boots with a default country derived from the BDF. If this
default country differs from the one provided in the notification, a race
condition can occur while updating the regulatory information back to
userspace. This potentially leads to driver having the incorrect regulatory
applied.

For example, suppose the regulatory domain for France (FR) is already
applied, and then the driver is loaded with a BDF that has the United
States (US) country programmed. When the driver finishes loading, the
regulatory domain shown in phyX still reflects the US regulatory settings.
This is incorrect, as the driver had already received a notification for
FR during hardware registration, but failed to process it properly due to
the race condition.

The race condition exists during driver initialization and hardware
registration:
- On driver load, the firmware sends BDF-based country regulatory rules,
  which are stored in default_regd via ath12k_reg_handle_chan_list().

- During hardware registration, a regulatory notification is triggered
  through:
    ath12k_mac_hw_register()
      -> ieee80211_register_hw()
        -> wiphy_register()
          -> wiphy_regulatory_register()
            -> reg_call_notifier()

  This sends a country code to the firmware, which responds with updated
  regulatory rules.

- After registration, ath12k_mac_hw_register() calls ath12k_regd_update(),
  which copies default_regd and passes it to the upper layers.

The race occurs between the firmware's response and the execution of
ath12k_regd_update(). If the firmware's new rules are processed before the
update call, the correct values are used. Otherwise, outdated boot-time
country settings are exposed to userspace.

To resolve this issue, introduce a completion mechanism within the hardware
group (ah). Trigger this completion whenever a regulatory change is
requested from the firmware. Then, in ath12k_regd_update(), wait for the
firmware to complete its regulatory processing before proceeding with the
update.

This ensures that during driver load, the default country is processed
first. However, before ath12k_regd_update() is called, the new regulatory
notification will have already been received by the driver. As a result, it
will wait for the firmware's regulatory processing to complete, and only
the final, correct regulatory domain will be updated to userspace.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
Changes in v2:
- Fixed uninitialed variable usage warnings (detected by clang)
---
 drivers/net/wireless/ath/ath12k/core.c |  4 ++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 15 +++++++++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/reg.h  |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 17 +++++++++++++++--
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ebc0560d40e3419130e4caf01c9b91bd9affb3bd..9c18a706dc3ae3b8c5b95d8575e778c8a9c898ba 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1470,6 +1470,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete(&ar->vdev_setup_done);
 			complete(&ar->vdev_delete_done);
 			complete(&ar->bss_survey_done);
+			complete(&ar->regd_update_completed);
 
 			wake_up(&ar->dp.tx_empty_waitq);
 			idr_for_each(&ar->txmgmt_idr,
@@ -1509,6 +1510,9 @@ static void ath12k_update_11d(struct work_struct *work)
 		ar = pdev->ar;
 
 		memcpy(&ar->alpha2, &arg.alpha2, 2);
+
+		reinit_completion(&ar->regd_update_completed);
+
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		if (ret)
 			ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 941db6e49d6eaeb03783f7714d433259d887820b..329f3e490a713b179413f73a4024448aedc363fd 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -804,6 +804,7 @@ struct ath12k {
 	enum ath12k_11d_state state_11d;
 	u8 alpha2[REG_ALPHA2_LEN];
 	bool regdom_set_by_user;
+	struct completion regd_update_completed;
 
 	struct completion fw_stats_complete;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87af8b48cb3fafcd364fd9ced4ff197..ef2e8398cbe8723c020aff03da5db7fa7fb2245e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10900,6 +10900,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			struct wmi_set_current_country_arg arg = {};
 
 			memcpy(&arg.alpha2, ar->alpha2, 2);
+			reinit_completion(&ar->regd_update_completed);
 			ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		}
 
@@ -12116,6 +12117,16 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		goto err_cleanup_if_combs;
 	}
 
+	/* Boot-time regulatory updates have already been processed.
+	 * Mark them as complete now, because after registration,
+	 * cfg80211 will notify us again if there are any pending hints.
+	 * We need to wait for those hints to be processed, so it's
+	 * important to mark the boot-time updates as complete before
+	 * proceeding with registration.
+	 */
+	for_each_ar(ah, ar, i)
+		complete(&ar->regd_update_completed);
+
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
@@ -12143,6 +12154,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
 			memcpy(&ar->alpha2, ab->new_alpha2, 2);
+
+			reinit_completion(&ar->regd_update_completed);
+
 			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
 			if (ret)
 				ath12k_warn(ar->ab,
@@ -12215,6 +12229,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->scan.on_channel);
 	init_completion(&ar->mlo_setup_done);
 	init_completion(&ar->completed_11d_scan);
+	init_completion(&ar->regd_update_completed);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 2598b39d5d7ee9b24ad8ed5d6de1bc5bbc6554e0..079dcb6d83df4eb487fb0dbf4088fb8cacca8f6e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -102,6 +102,8 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 
 	/* Send the reg change request to all the radios */
 	for_each_ar(ah, ar, i) {
+		reinit_completion(&ar->regd_update_completed);
+
 		if (ar->ab->hw_params->current_cc_support) {
 			memcpy(&current_arg.alpha2, request->alpha2, 2);
 			memcpy(&ar->alpha2, &current_arg.alpha2, 2);
@@ -272,9 +274,19 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
+	long time_left;
 
 	ab = ar->ab;
 
+	time_left = wait_for_completion_timeout(&ar->regd_update_completed,
+						ATH12K_REG_UPDATE_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath12k_warn(ab, "Timeout while waiting for regulatory update");
+		/* Even though timeout has occurred, still continue since at least boot
+		 * time data would be there to process
+		 */
+	}
+
 	supported_bands = ar->pdev->cap.supported_bands;
 	reg_cap = &ab->hal_reg_cap[ar->pdev_idx];
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 8af8e9ba462e90db3eb137885d0acd4b1cb2286e..fb508302c7f0f1fea2588ad4cf9d813da574d06b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -13,6 +13,8 @@
 struct ath12k_base;
 struct ath12k;
 
+#define ATH12K_REG_UPDATE_TIMEOUT_HZ	(3 * HZ)
+
 #define ATH12K_2GHZ_MAX_FREQUENCY	2495
 #define ATH12K_5GHZ_MAX_FREQUENCY	5920
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..db839fc835816c9a2d03d194547af506760f6c81 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6143,7 +6143,8 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k_reg_info *reg_info;
-	u8 pdev_idx;
+	struct ath12k *ar = NULL;
+	u8 pdev_idx = 255;
 	int ret;
 
 	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
@@ -6198,7 +6199,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	kfree(reg_info);
 
 	if (ret == ATH12K_REG_STATUS_VALID)
-		return ret;
+		goto out;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -6212,6 +6213,18 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	WARN_ON(1);
 
 out:
+	/* In some error cases, even a valid pdev_idx might not be available */
+	if (pdev_idx != 255)
+		ar = ab->pdevs[pdev_idx].ar;
+
+	/* During the boot-time update, 'ar' might not be allocated,
+	 * so the completion cannot be marked at that point.
+	 * This boot-time update is handled in ath12k_mac_hw_register()
+	 * before registering the hardware.
+	 */
+	if (ar)
+		complete(&ar->regd_update_completed);
+
 	return ret;
 }
 

---
base-commit: 7fb79ce2693c94f8f74bf62ad25a97e4b61721b8
change-id: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386


