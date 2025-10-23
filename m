Return-Path: <linux-kernel+bounces-866698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C29C00777
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F76501C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB830CD95;
	Thu, 23 Oct 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mL0wYE2d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1830C603
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215168; cv=none; b=fHBt/x2wnh2PvdBdk06F7cRUjEFgiDy3su9T+PN4Al6nMcm+MNIsMftxwtoq7GFSS0DQNCXF6dNa4MfFfAxSzkFBXZtIGUcdRkQbW0Yu5S9VfyTEIF8NReH+4a01DpILTE/0FJ3/6EDncvTP3ofbGMqEfV3Dv1XdkxEwHnzwcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215168; c=relaxed/simple;
	bh=xt8g4CkWUD5tNFuL4e7DXexZmzatqrNobgpEMGthfEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/y677d0LS4DBGRgx3ojYsQ6BA5bIdvF514/azVcaHi1uFmXbiWbd9eeUzZrcMs3L7qo4kl1KTVthhBGfh8rbeo4yvwSmh8pE8yOxk8fi1A1+sANOg8Xa1AHfmcn80j46BqdiFihJsrvcQ0rF4HfZHb57rIjdsGTh76Rh6pjO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mL0wYE2d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N84wtM021340
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wOyEzaoN+qW
	t6Jznp1azFKuIlaKA4mByl9VN5wTmOWM=; b=mL0wYE2dcg3zdMHZJBAlTA5hiNW
	WInhjP9s87NGQ1G5Tt2JpEJ93atbSoKMrUh/hm+FdnmewN75ZajdVAMStWEp9fN8
	h/EqX/W54xH0Ynk2DWQvb1L04F+XCwIdtFb/I71I/KfdtWzy3Qauyjre8V4zcOju
	Ae6JzHitP2u9k0SOCjaF0uNbmtU9idsukrZG7vygW0jesgxMLzAKFnimUSeweHGL
	H2cOiv63Hfn8O/K2scPzCmjF3UwEXCFWMG59cNvmQ5up9oGjXZtKlr0D4PNH2Pzo
	Uyaq3N4LaV+PHd7YKx2Yxk+bNUkqPoKDuNoQSl0a1vzHAcNS44/CaNixVcw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qhywn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e89265668fso19225061cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215162; x=1761819962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOyEzaoN+qWt6Jznp1azFKuIlaKA4mByl9VN5wTmOWM=;
        b=VJhYWAM7ZcGfgY90EV6UgECgkKsnTnH0GXgQe5aGdHfeMoF7J80pZq8V4/kSmjdcLJ
         iQwU+2qwmfIFKJ1ihXPKMcinhkOFbJpgXcIh5+Dvcmo6GOdTa2gdol09XKAB+THYXY5m
         W2DYlbYaB8exZr2MfxoB00dOrYBaX1gsXqGo7Zasksa57UgFRXMQ8DRARANjxUZn/ymb
         2cSbkNRMurefEUno2eH5mLPATNjpnIEMpJp7i0NBUGIo+iLVTI5qrMonWzLnjesNSsdg
         cFCPfhjvXNttlbLtIKfHZADAO6KHCFyu79YjnWaESlaz5zGe7yAfl/pPZuyvKAIzhhKN
         pXNw==
X-Forwarded-Encrypted: i=1; AJvYcCVIHqgU2r1ffMXarIjAntYzjaPpj+AV4Knqg18MyCdfKvynIqODq/mfLKCzKnatGHhCHc5Q9ucweCgJvcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwasBa7KuXEZ3JgqCtAqORoNunTBBmuvFNn/Obj6a+SIVw1zgm3
	XnOX1MGyTbpC65dGV1M7L+4Af/aZbY0EczrZg3LiDkVT70siifHyES60s/8LWrCFC0846NVLoPZ
	LkbRnzzb+LOI0kZvfW9gQLMYrF3gJKR2IKLKNtfvylCjl8genNer5UnKLDs2AvbwH/1Y=
X-Gm-Gg: ASbGncvFsFWPdajqbdjWGN3FZh26cEmM3cY6fNpzj4PBaIKkmBsYcr5kyzedsVeumUZ
	iPUKWzGOjaUNhNm7K2zCwHI+a8X7sLeCrlUi6zCf0Kz4luEwIDzjKPpZs6nF56qCHkHBGIjynC2
	y9uXcqoGIqMsL8IX6ZsHGOwTtmKWtP9EuNV8eIqbpcGTw9qMRgjIEvTM7puQbDn0yzRUYolCmL1
	0WphD8IARcGnvPXlSb4f/slGbsV8o/3ta5gpo4RA8htrhjtjHYaNqWswpw2FzjFtlPNjXtlUtug
	ymv+j1c5b93/HXHCuHO1BS9AULgGoVgufQIIkBHgGdKTYcVTsRN2DgtLAoissuaYEl/VRZG1eq8
	+qV5i8xYWFKLI
X-Received: by 2002:ac8:5a88:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4e89d1f1d58mr292503621cf.17.1761215161958;
        Thu, 23 Oct 2025 03:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUSOijjLnGfv14M5wyZrvWbp/YZECNCLSsoRITcid+nA4Im70rZl0l1Vk5yeIEAGTdk6BjIQ==
X-Received: by 2002:ac8:5a88:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4e89d1f1d58mr292503311cf.17.1761215161436;
        Thu, 23 Oct 2025 03:26:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Martino Facchin <m.facchin@arduino.cc>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 05/20] ASoC: qcom: q6asm: handle the responses after closing
Date: Thu, 23 Oct 2025 11:24:29 +0100
Message-ID: <20251023102444.88158-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX8QHz36xj23iG
 7kIA+h07sasvYR7L+0VT3oHvlDB1Co3H3ll0/Q2LvhLCapVattB6WlPL2YpcCdaF9AD+bKe+HPa
 b8xvKmVrJsaFYlk9hLJk9oFZx+yDxXQzlOxMie8Vfb4Q6vjmMT4aVJklgGsl/fZhdUCUmcVT/Mt
 62ZTztx8MCmE0ap9a9XJRFlYf7N9hcEtmpaouF2Pl83jQz6ayRF9V9SnO3qLWJ0iUv7Gf3HTx7y
 zgWDO0lcTWC7lyPn5CwFYZOHLHcoSoDQC5SkhHewVLpQ2U2RBRYtJ/lJvauBz1IXML1oS5mOhtI
 shgdWbwDTc6hnYiNqpHSOWoCCNMR7kaynQF3QGjUA3IO/ODFml66nDJlFmPTeSHK7MlV6xjrC1y
 ziCexlJ8zRH+3xk2Sb62IOfWv+MszQ==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa02bb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=yqanLTD2VdNSX0FXSJEA:9 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GPTeVqPkg4koOSyE3ZJIK_RObGMFIDhF
X-Proofpoint-ORIG-GUID: GPTeVqPkg4koOSyE3ZJIK_RObGMFIDhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

For record path, multiple read requests are queued to dsp in advance.
However when data stream is closed, the pending read requests are rejected
by the dsp and a response is sent to the driver, this case is not handled
in the driver resulting in errors like below

q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp

This is same for both write and eos.

Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
ASM_DATA_CMD_WRITE_V2 as expected response.

Reported-by: Martino Facchin <m.facchin@arduino.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 67e9ca18883c..4c3315d4e27d 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -638,6 +638,7 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			client_event = ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE;
 			break;
 		case ASM_STREAM_CMD_OPEN_WRITE_V3:
+		case ASM_DATA_CMD_WRITE_V2:
 		case ASM_STREAM_CMD_OPEN_READ_V3:
 		case ASM_STREAM_CMD_OPEN_READWRITE_V2:
 		case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
@@ -654,6 +655,10 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 				goto done;
 			}
 			break;
+		case ASM_DATA_CMD_EOS:
+		case ASM_DATA_CMD_READ_V2:
+			/* response as result of close stream */
+			break;
 		default:
 			dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
 				result->opcode);
-- 
2.51.0


