Return-Path: <linux-kernel+bounces-796702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3FB40614
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145DB1A80D10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370541E5B7C;
	Tue,  2 Sep 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBhk9YbG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EA2DECD2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821663; cv=none; b=iX2E+k60QlbyxpA9j85Ib3uEbfMF6ivkR+2pme6XJWeMa1mlwI6i6ty0f6+L/JcGCd5Jf9MgbHenK3BYgP3UzOUawB7wa8DmVLsjZUkLy+sRP5pJFZ66mtutdXzqX9GyZHmFmanTKgjIze8Lj3uYp7EiSnVH1ni9uKGsTFEI18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821663; c=relaxed/simple;
	bh=JJm99rnDzEe1ECFjAWGF6ytHuNYXto1CkMPXhCZn0eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCyS7ha9FkS0eZLcnFnlrimi59ov/84INIl8zJ40gEwT3KqLzQr/M/1G0CzF5egc/Rrn15t631fxhhmqIb0y6DmSojHNDL+GdOlQ+RdicDrJRi44tCxW1sHiEmq1b/sab16l8UGSa8zbj3YRuX+il7266fPQT/shmfkd4CAMhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBhk9YbG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B4iQK010134
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2az2Im644tqnDNw05Ee2bX+L6BhbJIk8rCO
	P5D6QQYo=; b=cBhk9YbGVfE1KJltBOSAjAVN3ty5dm2PKnQPH8+BkaNEkf5yn03
	Qi4tOiiNDX7w+w136jSnLYS2bzvpj88K17ja6jeQWIUOysuhNLjK9p6gJmN2v24z
	8JQc1wKnUF1v9P4ws1LJu/YU8Y14l5zRF+P9hXzLReCn2zSxnhfg9iQJcl1BfBYQ
	o7U/sczHXFUUN4bFAivgNv9rMWyZsYer227cw/f2OlqR4pv6dwGTZdIeaDs+VTLj
	uriMTvcTB8dejNN4kYP72b3AblUeXhLUi7hGj9GhCtXuKXI0keWQ5y5/T+ZtSeFf
	nHb3Hxaz1F7lvv7cKyOlvPlnNNjLt+Rn0sw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjg0ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:01:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3472b7efeso12330941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821659; x=1757426459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2az2Im644tqnDNw05Ee2bX+L6BhbJIk8rCOP5D6QQYo=;
        b=ldjeHhi0QYLEbjZGb+g+fb99+5IVrCFieluB5xDMqnLVwXGIuoMG2wjRtSSVMR8rR5
         ZAPZfXxiEL7g2BlypISugxWpOuycqAxOZFvNKo5q6H4hL/39L/dv9RSHGRK7uZCpI/oP
         +6DyNI0tAPBvebJWV9VcH/I5St+iVoxIsGHyHsVSLz5MsiL0kr3hLT/Tm4ApaY9IcmeB
         G+sabpbFqk6BjIl5zduzP35kx5eclWncdkYIXUvdCp09dGkkrV9YVMuYrlliNNfiaxB7
         t56dujSjpBJmuLdRKurPIebVk2tOIUI3C3tVgmd/oqkIOXJMjio5PipMH05CDk/neM6k
         G8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVziEKMR7vW8v93LhAHI2wRXVH+omzevZnjwrGmm+Nx8nghmtSLFhhP3+mlR4YDHriqyUwc1df7SJ6a5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpbONOb+OW7Z4Y6sC9GC1nd0YDMzy/2bwJFgjgA11WV+71/qI
	h/SzPhXXG5rhzM7ZSmu2emkD69/1ubhSchBOoRzlD05GcxDKjQGOUr/A+yyRkIYjW919y/E0JKa
	WWyed7jPFqyQqng4NxiXyQdDu+wPbb+x9tlZSHVE0wfucv1hPG+DJSAaVcTVAyIIM2VE=
X-Gm-Gg: ASbGncs/jkqm8xGTgZEBdAJqzqvOkT+pUBiLuEWME/ithgQKt/0KiniCU9KWH6ShpIe
	+4IHuThH7A3/Y+vba4cLC9JwOFYrDPIx80CMNF7uzmKz1RLRQS+uuvSE90ZgTNnj4Ypa/U/jIqt
	Eic+2YzwA9W45hfSt9zNaup8QcUKaeVZAWWvMgKZKsL0UP2bWGqJM9VmIMiZ7uS/yBjSer6jtGs
	anHBLykYlvTpjxNS3E0Bmn/8x4sjYGraWXxQ1ApnA1fw73js+ErxZNqw0xbqYkgaGnJLSWyi2ps
	g9lcym8l+pNV8BgloZmkxXWHATbHCfswUBfh8qdX8gtz/8jvpMCWTw==
X-Received: by 2002:a05:622a:1111:b0:4b3:7ec:d238 with SMTP id d75a77b69052e-4b31b85ed4fmr135597401cf.4.1756821656658;
        Tue, 02 Sep 2025 07:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPhaC3o/U4JWaz8rPrv8EPnrnVo7uBTe7rQa0n7CsRBSYcKVshYqyzlm+d72I/Hi9srgNHSA==
X-Received: by 2002:a05:622a:1111:b0:4b3:7ec:d238 with SMTP id d75a77b69052e-4b31b85ed4fmr135595041cf.4.1756821654981;
        Tue, 02 Sep 2025 07:00:54 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:54 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/6] ASoC: qcom: add support for Glymur
Date: Tue,  2 Sep 2025 15:00:38 +0100
Message-ID: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6f89c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=FrvE4Lm6qVnUI7UI9j8A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: gtrDEPvUjJEu8QJLwAJr3ypPExzZc2GI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXws2AUJxWzmq6
 ETrhHvgjIOZWmRDdkCNcjjLLREqjgGcTIDUd197VSKGmiBnae9Oj2JVuno+D5Njm/pv0wP2gbwk
 +JKTjF4AIQ30PmmFp2uPxbNxWd57u1s8fAMh9utX335Pn/2lXuIjgC8gMFNy7KIaWESYu6hVJ07
 t44p1PZA1Z7d/CR0yjUKFPxFycI3eD0IL1/Vc1vf/XduUj3QT4ico5U6fFHZ1ivZ3RTsCq1Wycz
 VKQNszaeQ8ot1Cxjdj+TamY8amOXvMjbjwmrf7g2b1VJLj8ejt+mfI+xEbETUuy2P4EfEHZj4cZ
 FXS6XC698qwaaSRiG8BP4AnHHSTziGGj8qdCci1Qq1mR4iTLpeIup9BSYgQYUtwXgpfTqwiGPAw
 IVTJFxSu
X-Proofpoint-ORIG-GUID: gtrDEPvUjJEu8QJLwAJr3ypPExzZc2GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

This patchset adds basic support for Glymur sound card,
- by reusing x1e80100 snd card machine
- reusing lpass wsa and va codec macro which are identical to v2.9 codec version.

For now only tested WSA and VA, which is why tx and rx codec macros are
not added as part of this series.

Tested this on Glymur reference platform.

thanks,
Srini

Srinivas Kandagatla (6):
  ASoC: qcom: x1e80100: set card driver name from match data
  ASoC: dt-bindings: qcom,sm8250: Add glymur sound card
  ASoC: qcom: x1e80100: add compatible for glymur SoC
  ASoC: dt-bindings: qcom: Add Glymur LPASS wsa and va macro codecs
  ASoC: codecs: lpass-macro: add Codec version 2.9
  ASoC: codecs: lpass-wsa-macro: add Codev version 2.9

 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml       | 1 +
 .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml      | 1 +
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml     | 1 +
 sound/soc/codecs/lpass-macro-common.h                        | 1 +
 sound/soc/codecs/lpass-va-macro.c                            | 2 ++
 sound/soc/codecs/lpass-wsa-macro.c                           | 2 ++
 sound/soc/qcom/x1e80100.c                                    | 5 +++--
 7 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.50.0


