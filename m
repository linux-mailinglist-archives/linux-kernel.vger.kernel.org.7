Return-Path: <linux-kernel+bounces-884270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BBC2FC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92C404F5827
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE73126CE;
	Tue,  4 Nov 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0U9GcoE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdtWQYB8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DA311941
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243928; cv=none; b=N9p8A6g60VC75UksjhPTWDDw0W66dqcU/2pjXlXaAk+qO62rYJTis5KlX8RSW/7Hlv9mAbHp+0EhIxNfS1FNNFVRJRvwbAKB11G6E7rBcqcLs4NkNJowxwFnoKvPLiA8vA/bd6upk373M8fCqWC+3CCrIHyu8xnGn0uCl3nk2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243928; c=relaxed/simple;
	bh=tgEcZ89f9J1zb8cPHLxZO8gPRlautjCq+o2xsk4hipA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAz2AFNPFEBVvgllNcuuAxHuloUx6ErcFYcFRH7jLdV0D0nmtpGS97tu6rlo2g/kfhVtUFKzEiUl2tizIV4YSO9gJlaZtNRIKQ+pC6jE0vPoI9hB7m1Iumrjo7ixXHiC/RkDBvxW2z2XHKHkeK/laATMwFQ2W2kNe44CHX6lIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y0U9GcoE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdtWQYB8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A439N5M3667854
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z1m0Kr0dkc5wiGTjWy8T1DcZZ4nsJuSSzl8/gqgBkD4=; b=Y0U9GcoEmMj6h1J3
	e7euhBy8rX+YS/QUe4fmFN83ssCN4NivF2giFfvt/1LUNUtnZPE5lzUjRnQ3dNSU
	CUy6csiUV/9LgjQoA1DkBqhRlPfRcGwevyPErPCQQD0FiRcS/DwsClzWngTwREYj
	5iyhXpH6OVhzFBdnZdQFmVo40WqzaYZO0GiQAyoDyubh5kMTJDW8nc3SDq1Vd4qk
	Bckxh+c2wYcwwiPFc1ADaqSHYkhwzOZ5OHmr/Uuq2fv4RD28Q27PzZmJpzUj3rVR
	qGCM7Vph+OSLPUtnOzqj+fDCt8xeWUOiITrRU3VKLNmBfH1dtbwHJ1QJYUz775qT
	nZCqMA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ffj6ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:12:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33da21394adso6364312a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243925; x=1762848725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1m0Kr0dkc5wiGTjWy8T1DcZZ4nsJuSSzl8/gqgBkD4=;
        b=PdtWQYB8T6ENp497C45P4E+t7WbdlTOUxiSCMQyAgRMXu/fnrYRiM2lySK/SqgX9kq
         0W01wNNrK1YM+qygGEA7eqzKwTD9F14rJ5A7H7BcdRlGXk1xdtRBOJXgE0jS4BWGmrIJ
         E2Xwg5rzdvCXNc+4Cc3RpJJA7l7KMr9AlgyiO6ksjvEMtWuizrk0CW23tSDETOUy5iEb
         Vy8dGQrIP89AJ6XCmWw7pct8fMQYYQqKbOnPfmokoJpcYGgs8j7QiEmoFZ0Ff6exDdpe
         TdW2KjmcDWKWu31yVQ0drx3x1BpwP0rXvj38/OMfCfsTf9Ep1LYEmYBkNu4ejhR5RblQ
         t+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243925; x=1762848725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1m0Kr0dkc5wiGTjWy8T1DcZZ4nsJuSSzl8/gqgBkD4=;
        b=k74V2OXdtpIRu/9dDB2Qnxur7tiLeJC9yEug2iM8IK99RwFGcvJKtX9A7x6FZKSf6r
         KMCs0/Su3l1d6vmJ9N4qdPshlRuZvRdxhrPjRaWqxmI+Q0pOczoVkdoQjddHNdtZH0Xo
         ZWGgrbp9n3zKSvg0tuH1ThI3BWOo/tWmzkYDPtd8pNaCZ5yr/uMhNRgcgLlc+kj4c+i3
         CGsp74NuTUHwoY/0LCwt/2d+8Q7kn/6GLNis4jbIyuWJWMkQoZwRCVwkC80G9Kh5p1BV
         VUoOmlsrlvaN5VBiKOcEKflVZWTw/3If4tUPD/MODBV4sStdrSPjt+NgWlIm7YDVSbdO
         ReTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkOxZSyH42db8Hx6nmhEzzCHmvQf7iK2icXV/En34kkW1QVVfrPwSQ53O7a/u+XcHyUqb+kIHQR+pqS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDAwph1ret4k0A2Z9nXj9eLCgcYy3eMV/ZjSnDvkndUb7f+gC
	1+mTSVf9G7vJ3g/UzgBJihG1GwVvqCB5Uqvy2Aj3BG+3Z42XtFSmuFMxZVmA3M0EdZOo53CD7g3
	4OV7Jvfcc1wTFjPJYIT3s3r/Ej+BhZ8SFoHTvLGL9BEtc+qEagh1nlTFtAxShOLSmYAQ=
X-Gm-Gg: ASbGncskVt1wU+sfEqNWcyT0Hviqw1HUredoZmb2QMOknFm4qgw9VLDhz0ek/nCycHh
	DMsLL853ZnfRBFEgWKKmOB9P4ykfVccinocY/qXGjlIvdzlLYwio8Y4TD4mnKfaOxyV/mxnrzUl
	njPPsFq3jUUOrTH8FKT0bZGXuG5G4bbrnGpl0y04NtBsfP7etaKl/UphY1jmStSd4MJl9dvQU7B
	wHHw+1mJwuy1Z9phD53qo2doxm4g7u1qDNYmnUmCcqxUudgmKyFFTNpC43Tp4W3YynkRZ+rFf/I
	2x86dWAdMSgB9dzdq+nX3/s9Jh170gaR10A4De7VY+wGrzcXqPfb1owzdeNkyn9P7H9UI463eSZ
	Q0p8953TChYxBtZLP+0v4rCgh+dJAcZ4NS70umE8rE6OjQS/Y60uiU/kEWj0qYA1xktCt1dmNow
	==
X-Received: by 2002:a17:90b:3e50:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-340ad5e0162mr16381409a91.5.1762243924846;
        Tue, 04 Nov 2025 00:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj2KWf1Hf5n0a5HTuJmIkpr+kXPrsSF+FEblQ8RcHdMPTlmXDcUzq0sPp0IIEkZuvCOJ+H0A==
X-Received: by 2002:a17:90b:3e50:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-340ad5e0162mr16381365a91.5.1762243924255;
        Tue, 04 Nov 2025 00:12:04 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2f12sm3601755a91.5.2025.11.04.00.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:12:03 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 16:11:45 +0800
Subject: [PATCH v3 1/5] media: qcom: iris: Improve format alignment for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-iris_encoder_enhancements-v3-1-63b0c431b4d0@oss.qualcomm.com>
References: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
In-Reply-To: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243916; l=5143;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=tgEcZ89f9J1zb8cPHLxZO8gPRlautjCq+o2xsk4hipA=;
 b=gnvMRmgCxszox4DbwAgVs9YZGWzAkXZkzIJgToYEYLPTGmKwH8kfCCzEEB0mOXFK/yJTC9vZf
 alH7CJR5okTAWDp4cLVwfPkIETByn7mtQ0csqMy4kHSk8xD1KQW5ryr
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=6909b555 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wKEeJz3Uo1OqNUEJEIgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: l9MMNOS9_umuyTZv0IIbi-pgilICBHTh
X-Proofpoint-ORIG-GUID: l9MMNOS9_umuyTZv0IIbi-pgilICBHTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfX+9ze+WlFhuZi
 EFh1Q+wqh8pfIDe8E8PR6i0O8Nq3dAPLJCjak7TrfbuE0zHoVO1f5BPYg+n5rpxowUyHar64XuL
 C17Z4DgFkYBkoehC3SokPzpTWH7SpXB2xQlP2F8SxM7qvnli/ej4aahgqOzIHjaZe8Wd8LLzx7V
 gkscgIg8w9xgc0/Ml8dlHbi7TcUOPzs1fhYCGpLdnkUiLmg1X5BHtTLJ9ozf1SrgxdUd0EKf6uP
 KVtEFqB99ZeToNgsvCX0v9QCExMCF4cMO+W+Hw6uyfwYJ4+NzO46s25rgWVqBOgaI8YqV2ejMa2
 sqAs0mwH+HWzFm23YGtLqS/fW3GTSB9oC7PIS4hzlQxy2Tr3efNIRT1NsHxX52zF2t8Of/eEIHq
 wgL0l9DLgM/IIHCcw3u73SsPvKkzBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040066

Add members enc_raw_width, enc_raw_height to the struct iris_inst to
support codec alignment requirements.

HFI_PROP_CROP_OFFSETS is used to inform the firmware of the region
of interest, rather than indicating that the codec supports crop.
Therefore, the crop handling has been corrected accordingly.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 23 ++++++++++++++++------
 drivers/media/platform/qcom/iris/iris_instance.h   |  4 ++++
 drivers/media/platform/qcom/iris/iris_venc.c       | 10 ++++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a14250832440099e4cf3835b4aedfb749e8..2469e027706fb6c9c0b95be11109c3cd0f8d70ce 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -168,8 +168,7 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
 
 static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 {
-	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-		inst->fmt_src->fmt.pix_mp.height;
+	u32 resolution = inst->enc_raw_width << 16 | inst->enc_raw_height;
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 
 	return iris_hfi_gen2_session_set_property(inst,
@@ -216,8 +215,11 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 	u32 bottom_offset, right_offset;
 	u32 left_offset, top_offset;
+	u32 codec_align;
 	u32 payload[2];
 
+	codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
+
 	if (inst->domain == DECODER) {
 		if (V4L2_TYPE_IS_OUTPUT(plane)) {
 			bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
@@ -231,10 +233,19 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			top_offset = inst->compose.top;
 		}
 	} else {
-		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
-		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
-		left_offset = inst->crop.left;
-		top_offset = inst->crop.top;
+		if (V4L2_TYPE_IS_OUTPUT(plane)) {
+			bottom_offset = (inst->enc_raw_height - inst->crop.height);
+			right_offset = (inst->enc_raw_width - inst->crop.width);
+			left_offset = inst->crop.left;
+			top_offset = inst->crop.top;
+		} else {
+			bottom_offset = (ALIGN(inst->enc_raw_height, codec_align) -
+					inst->enc_raw_height);
+			right_offset = (ALIGN(inst->enc_raw_width, codec_align) -
+					inst->enc_raw_width);
+			left_offset = 0;
+			top_offset = 0;
+		}
 	}
 
 	payload[0] = FIELD_PREP(GENMASK(31, 16), left_offset) | top_offset;
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..fbae1662947df73bb3d10b7892839fa1076b7e61 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,8 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: raw image width for encoder instance
+ * @enc_raw_height: raw image height for encoder instance
  */
 
 struct iris_inst {
@@ -102,6 +104,8 @@ struct iris_inst {
 	u32				frame_rate;
 	u32				operating_rate;
 	u32				hfi_rc_type;
+	u32				enc_raw_width;
+	u32				enc_raw_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..7ad747d2272f029e69a56572a188a032f898a3fb 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -62,12 +62,15 @@ int iris_venc_inst_init(struct iris_inst *inst)
 
 	inst->crop.left = 0;
 	inst->crop.top = 0;
-	inst->crop.width = f->fmt.pix_mp.width;
-	inst->crop.height = f->fmt.pix_mp.height;
+	inst->crop.width = DEFAULT_WIDTH;
+	inst->crop.height = DEFAULT_HEIGHT;
 
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;
 
+	inst->enc_raw_width = DEFAULT_WIDTH;
+	inst->enc_raw_height = DEFAULT_HEIGHT;
+
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
 
@@ -249,6 +252,9 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
 
+	inst->enc_raw_width = f->fmt.pix_mp.width;
+	inst->enc_raw_height = f->fmt.pix_mp.height;
+
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
 		inst->crop.top = 0;

-- 
2.43.0


