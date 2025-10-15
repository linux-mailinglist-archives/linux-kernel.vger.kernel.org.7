Return-Path: <linux-kernel+bounces-854564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FABDEB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336B1481618
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3323ABBB;
	Wed, 15 Oct 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mHotCi92"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BC1DB54C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534297; cv=none; b=RJBWEwohGS4cmQrI2yNHr2Upv7QpNtDrGrjQ5iyOOJ4MnMpkg3N6zfAcL/Bdw/Tfeur78lH2g/K/EhnTcuEhGvQCbsA/Ix1EUINMn8DF+WeJydMB5KFGRjZCGQa4sl4U05ASVWvxxREI62A/WiygemvKhn7TdoaaxtSMLafQnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534297; c=relaxed/simple;
	bh=WgksRNnJLD6BqxUz9vyEhSOn1ol4D8nCWHkD1yAbE7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6uU9UjoFDTpOsxLdmzMXKxHa5WGpQLAm47nYv1XE5EafSbqUctavmcT8ljgiGZ0GzWcUnnuPIH4M3TE/4txoDwPnatOLWfeXpiKgzbP6f8LAEpLsb1VfHvU2Kg1WBkRczp7IYxvP9TXhVPfdWmRg+WPCx8qCJBBZmL7CM0R5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mHotCi92; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAbr3P004089
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zlyb2ILEilB
	Be+0NeB1eqEutKyYbzy1mNlFgAEnueiM=; b=mHotCi92zo5HlrF8sjm2M+zlov3
	+GAmrSaRqX0Y7OZNSJK2VkFOPBl05IvyywGfNPM1b2NJq2VyzmzFzFXygJsmmqPP
	UrhXQDhnPV/EOI4nosDwKDIT98hdR5DXr/scSJDmZ1y23C0c1boLLSSWGD9BcyLm
	d8i2zvuOmQ56sOt/lmVSc9CRioKNi9IKqkJZ2cXu5GCCTqitx+FJal+FzBqZAO3n
	iT1j5cU7XgJnb+o8E1lXJQ1Yhcu2HKFopSgEhfsiA4oEWH35bLVZPdwRy+EE4hoE
	3rydXYHleeHwzOZfv/hJdgEg6FHmLetz6FCtPEc0CPjATA7jz21ekFlJR7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwptcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8635d475527so4065028485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534293; x=1761139093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlyb2ILEilBBe+0NeB1eqEutKyYbzy1mNlFgAEnueiM=;
        b=LXm8CiQ9OBeladUyHt2ojygai0INcnlRMDhjhJnsLiqLk4zCvILeZMtfLdKg2rHk/h
         I/aa9BAhiGlgbSVJdieliKTVl/GuZrLCIqu5/8Uwb/HzMxb/sfVm0oYfcdfheuIsM0QH
         5GpAACIo7AQ7NEUcILlt5mL/PDF4mAKJYNc40bIu9SjbBLxyWXt1Rw6lUnafu3z8uNhA
         mnE8AiR7ATXxb3698nQTOaFZ36TmvqHRuczZtvpDm5rHQHwiaKF2YoNCGUrjdJ07LuBo
         8t2d39FOg00e5AfiR0f6zxanZpMEk6xmyGhEE2SoR/qdG5+ecsL92HXFjnuJqI/BSXK3
         TQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUvp/u01Xn8a2GzatMuso/ryxK23VIL/SYucFl9thAqWPGZFH4zxWXe+hqEHfCl4srkLVA9eKn7mRw4F/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDoC3NjeMqTopgO54Oxc9+r9B66oRHYoQaeQvcILlJuLZuzVo
	6nT11JP2sfIYyXobnLAlVIq2kLFzeyMWh1nQqL+jev6F+TRWccn566OFqIGWNsVnzV9HjcN8nkt
	t85TsVp9CHH5R1btUP67Lk0X8RgVj3O7RCIE6+JI7zXwU+p184MhFi2OKsSVNU6WgRUE=
X-Gm-Gg: ASbGncv6PEhOhfq1xmWyDn39rQbiQUXsZcc7xSD/mypZjYXFAD4olc6ixCPag7ycv7e
	4atdP8uE1MR7ch8+YVKR36NNrzcRW/lq8nuJjQbZNjiLSKAuHh7Ao8rHuHJC6VhAdbppOqjRgNV
	Pd7iuzV24tkUeofYcaqbz4BQcN9P3LAKWIxCjmBAMj8QbTfKI2cg6DR1moSLTurOh1GRnPK7q6s
	jE1uOukls0Lia55xhiwD6GAwxRsNPt/s6ujBxqswhnPv56kaTqf5NTcjwJxWQQY8yArq8P1Qcfh
	IahYf5FsNPs/JYMC0lPzyqaYu04ewXkpiHPFEpgv3phRg0jFBr1Rqg==
X-Received: by 2002:ac8:5d0e:0:b0:4e8:8de5:fbb2 with SMTP id d75a77b69052e-4e88de600b0mr9882121cf.70.1760534292381;
        Wed, 15 Oct 2025 06:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGifIQbCESc9SGhY2SMFQxwvgmX8sW9h2/sx0PYFUmxrzn6ej7nKB9DswF8DGHPCO6IAfidCg==
X-Received: by 2002:ac8:5d0e:0:b0:4e8:8de5:fbb2 with SMTP id d75a77b69052e-4e88de600b0mr9881381cf.70.1760534291735;
        Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
Date: Wed, 15 Oct 2025 14:17:35 +0100
Message-ID: <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX2oyzUc36Vnn+
 aCeEsyz1k6bZCObzgAUgT/UXCj4EZk1GSJqc8bZi3jFkUvxtCqUt1z9VlGSGw4+S90elwsms5uO
 95qHicZ1gNkLwI9dmpW8qgH+5tyhbOPgr/0hNPu8Ynndij00HJu2dMOHt0A4bLiWa4C7jzo9sNi
 60VOmX8UOk20xjXShm1GFCGBiQKw4OzydwD+5PsEo8hbVm+ayKvD6mjuHytQm0WpQ61sGrPA7tG
 pxrC5YwJpGIaaHLuzl9RIAfx3SUHrkC+CyXcL7WNMf9iD+2msg2uOt9fwhB+VlsY7YpuXA4ufb3
 DzMCTzb2qDfG9gNr2mxT9Yrzpqejwm04RbpgoLrMAdqXBs+L8o0yAk1/5son+AZfAvYzvsFxSbB
 dXbgn3VNcd2qYiZigFMhuVZfB8Uteg==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef9f16 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=yqanLTD2VdNSX0FXSJEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: MdpZhlV9Eiv-WvR3ereXyAXslzRGbH5q
X-Proofpoint-ORIG-GUID: MdpZhlV9Eiv-WvR3ereXyAXslzRGbH5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

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
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 06a802f9dba5..371389c8fa7a 100644
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


