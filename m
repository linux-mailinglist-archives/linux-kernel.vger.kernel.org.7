Return-Path: <linux-kernel+bounces-838814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF4BB033D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10434169900
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE52DAFDF;
	Wed,  1 Oct 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WVuelvFh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9D2D9EFF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318716; cv=none; b=TSmYxnltDVSftJPPxRda3JuoqskcuzqB1A7TtCR82htZtWLHQWSty8QpVWA0KFa6VwIsgxjNk2M6i2CabMUdZ12W2FRniUgUP96pYOa6MrBUcqb8h0vlgQui8Yqj9ONQbSd2BDnCGctw0eRqMbE/x43iYzb1bNXcHXGDBAF/bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318716; c=relaxed/simple;
	bh=L4Cyw3GgF6Au8o6Hny+g4N/DoHBQ9SVqEs390lXRzGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jcc1z5KDpq3hVyuZZMqbf8afct59PrfNeOmbRsDxkG2DyP/BITW54Xf3+K4VCXrcI40PlCHlUfrFlvi08mwVmyGm7Y7MEj0/3pCx/jKgNMoU68sFFvxyZ0334AtHmOKD7QQh4P1W6SPVX6JJvYQE8+BrWLdDtkXbKEt1wQU/UyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WVuelvFh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5919a4sK030669
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 11:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yE6v5/M6wV7yegUaBo1axPJLG+xPn73fkfkm/kPY/U=; b=WVuelvFh3tCC8Hra
	AiJBSdi/mvjV/CsWFQiyLIo6iWkbpFnBxkvi7W5CgSlVOgA5drSDoxdBQQ1172yy
	pbOO/pGs/ENmxJwbCQHw2Nr5okuv8gGruorxJYg+PZ236po6EDqB0tCxKv5aCCVX
	IzTkVzKfgILAE1d9Mt5buu2FWmnxs1csOba6Dvd8KqML4gIU+EN0pTc3zsXN0Jfv
	V0PZtEqqTBlLx7qwcLw4V4I4Xs6wnDvqgKw63VETEBXzIL9LWY5MYrzUeg12I0B+
	61cmV0JkRQWd9MI7/yfxxW1ODql1QCYNigkU2FctJt7abgE9WJTcWL2dirLjFf8t
	ZR9dqA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdm6cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:38:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5533921eb2so4998655a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318713; x=1759923513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yE6v5/M6wV7yegUaBo1axPJLG+xPn73fkfkm/kPY/U=;
        b=qQqURkVmbFEO2RMg4ZqjaadwUh96hXm4GzCtRMiAXaiIGkgqZIwykfeX/LlKwSzosi
         QIY4CpGOBZIFPtNE/GNRbMlW1Reg/mqVfEdSj5gZF+p+Rrwn/vOi+/geL1O2eHABstTD
         AdtweCZZdC66XsNqwOeim0GZhXXac9HL2dTcqAqt86BTCZOEwJ+O8Tv7aNxRMsg2zABD
         nu4mRXg1NJf8wW1cjnhAMQJfu0oBFWPW2dEaZXVcd0/sHmOrSRJsbcm6iNyZLuBuH32D
         KsD46vVGEF1zGWcTO8wO6YdYrttwSzw5xjYZpzL8sy2DMjAaU2mQhavETCymshJZJzPO
         bTew==
X-Forwarded-Encrypted: i=1; AJvYcCUm9+rAOKMNqzgYI9sVBFYNQOAZSZpo5qXLXfpCrFTpukygSVIXM/2g8z9/FwVrI6Cyy2Lk4a8fImrCQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Dlu5Z5M03QN8pCfJOJILv4ZIiiDdeddDHpq4i9tN6lzmV1JV
	FPRrQeOoh1xAFd2B3Zr1i6nAV7Zu96xRiu+Q3azbSpIUl+xOAg1Yj3k96IXyzGedQdnr/FoDcDJ
	HF3hgaTqBSUve4Qd/QW7+4Db5uU+7hv9/VzuX6+X/Lr8NJOPun3oP4A1awaB32uphQDk=
X-Gm-Gg: ASbGnctk9LqQY6UEWsvAlBiEPMegnvO3ozA47QNp3OCZV4Yng3ItDNvNgCP4mE6wLfx
	LaLQ5G93etAQb97xYeiYBsaWLcB2whZpliX+YkH2yVAFhIfmNogCXt/zi3lDKQEon8C09rwgmu5
	BvtI4HRE4t7l7Ee9cVu8Nn2shQ+Oo8M1Hi0PIA5wCJoypBGRJskvvrK97Qcj6PEJH02ZY71HkUu
	9Z08OXo87O+XXgQKx7x4t0BquDXx/ygBirnSQWRcoBoAj01lIygofdxeuoF9YtBT/hK2MGTmfMf
	GztXBYmACfVoTGXcylbExMkfSZIjPvpHgsqZiEZ+Z/Zo0CsBzqwYrSpr8t1M7lg7Udu2qujZrcr
	vV+EAcVg=
X-Received: by 2002:a17:90b:4ad1:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-339a6f2e7e2mr3962090a91.17.1759318713115;
        Wed, 01 Oct 2025 04:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIxwvyET/Ieuj5Ju7O5ebre8+IpT9Z4SrRxpt+5+Pe+dnBwvtlu0iBKTtKy6pMTTWKEO/JIg==
X-Received: by 2002:a17:90b:4ad1:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-339a6f2e7e2mr3962059a91.17.1759318712660;
        Wed, 01 Oct 2025 04:38:32 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399ce47d7csm1861646a91.10.2025.10.01.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:38:32 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 01 Oct 2025 17:08:20 +0530
Subject: [PATCH 2/2] ufs: host: scale ICE clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-enable-ufs-ice-clock-scaling-v1-2-ec956160b696@oss.qualcomm.com>
References: <20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com>
In-Reply-To: <20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: QOMwGazEqvHezeGtRhudo3T8GOSf51Km
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dd12ba cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=5PmQtxlypCO8_UJlTPUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: QOMwGazEqvHezeGtRhudo3T8GOSf51Km
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXz5+2nC2jRxZs
 xy+fViRA0lf9bqSNAufq7tLzylzy/5E4RIdTLVnEGgD5UkpkcNjnfXfHRM+dCe3WrLah7K0yIKN
 vOPNIq/83ngeJ4dh5eHRGxOHtSYzRJ7k/u1ZtWVheaVkAP6Z9UcsGRIwBh4PFae6Ok5/9sorJK0
 gK1OKVhP92gwriRNYoRRrMh7MG93JcRB5Wr5Ms0G5GZQ1IO2ax1wjpvS//syheZ8+JjJvC+o1wP
 XtpqgJYwUkybL8M1CWfblzw7yWNN3shP6FFPWM4WZkE6hezdOVhNfElBy/hSnDkab/y5WXXqyKI
 RqqMdwDTVpZR/RF7Inliq1eVCDanXtsqgyLEsa0x7Ls8GqeRyhETRnq5AG+vJTbqpaI1gauooR2
 kho/cjpPQCa+xzZx49KmxoZMqwnU9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

Scale ICE clock from ufs controller.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3e83dc51d53857d5a855df4e4dfa837747559dad..2964b95a4423e887c0414ed9399cc02d37b5229a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -305,6 +305,13 @@ static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
 	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
 }
 
+static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		return qcom_ice_scale_clk(host->ice, scale_up);
+	return 0;
+}
+
 static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 	.keyslot_program	= ufs_qcom_ice_keyslot_program,
 	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
@@ -339,6 +346,11 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
 {
 }
 
+static inline int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
+{
+	return 0;
+}
+
 #endif
 
 static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
@@ -1636,6 +1648,8 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
 		else
 			err = ufs_qcom_clk_scale_down_post_change(hba, target_freq);
 
+		if (!err)
+			err = ufs_qcom_ice_scale_clk(host, scale_up);
 
 		if (err) {
 			ufshcd_uic_hibern8_exit(hba);

-- 
2.34.1


