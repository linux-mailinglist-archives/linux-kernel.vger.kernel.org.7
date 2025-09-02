Return-Path: <linux-kernel+bounces-796704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26372B40629
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8743617B063
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2A307486;
	Tue,  2 Sep 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X99/i/cq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60C2FB97F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821666; cv=none; b=WZO+TfW0jD3VtXh+ID10OWp4b+BfQyMNrAdbDxJntZ5O6wi4xIS/CKUSK6Pd2aIZk3Y7TZiUKS5F/xltm3rJpApCZ2RQoc/wSr03kgDwZ4RJdZxHRvOmjUY9/UIMPbGBYnNbU6pVONhnTrzO/L19DKXp486g7OBNnJbKUZWgRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821666; c=relaxed/simple;
	bh=gEpj7b+o020sV6p7lpCzjnDqFYnfMtxrY4cMk3OFcWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvAjMywMp99gNXN3jzXnpTBOho9UTK8rVRAGmLPp6o7VRdAMTETIEhMDjffH1UFyiOlPuu9vsx+FNGIXk7TDEsHSJx2z5EgmAWMDwV+n/Svv7K2XRDzfbJ9hVByAc1Qjj8BW90AAbhCLvTiC4zbHVjYmsgK3dMJUc+ba073hLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X99/i/cq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B53QI027881
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=X4nCKgYxQJj
	fMP/VUT4XYH1vbsoebu/W1HveCS5YCMM=; b=X99/i/cqbpVctClptjZ2uSWd9i6
	HSdn+KG6rJ/lqjfyYfA7BUhxLOoc6rVr8UAQ1gvLZF0lZH3zV7cehzfWwkDCenN9
	ErHysU/1djCMU+8n9DMc+jbIFNUiDambxv8Po64dYH6vN8oq7e+fjt/UcxAeuLje
	cjA2FFzgYEsA/DoUYISTtOgz9jtybawo/OI5b01Sa84kkysjIgtt4FZHoUDDbOa1
	ogw+inb+7c56Uc5FiYTtJnVyDYDBNWTNuiwdBnLHZFQQi7Rp5P2N+Te5XYai41TL
	rRxDlEFf33GdxN7YPGtpVSkI8Dl09nOePP4h1znU9f0zKWmiUxcLeUyuOcQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv02gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:00:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-89606c409c5so74417241.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821659; x=1757426459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4nCKgYxQJjfMP/VUT4XYH1vbsoebu/W1HveCS5YCMM=;
        b=uZlSuLj2+4FbbuKyrAJ+eKMLz6v+8kHe/XYxhl4sFNIPC8B8Rc4QKOUwEd4ZsLals2
         8Jo6jkS0OPwPRbjfQgfp3mdNL3cUL4y0x+xTRXkBNGkyHMAF9yNOGefAn7+e85W7ccqd
         VrShBRa5HoCf1PNFGOncI0t+W8OK2y+MQztSGr/Uodkwg3l94qWz+9SAFL4lncsvz4CA
         xpbOmeHcWzDUz8A3TEE33mos2XJpyH5h8zSaO6phEX8OqemZAoWNgMcUgyam+jLun6K0
         LewMnFn8Mc0az2X+GLRUJQXhSQJrTm6y5U3lyKhGQlAdQfSKlFt+04798sCAatz5UEJz
         fYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMLLeyIYTvaX4DSENaCbqV0SkQJ7BmxWPZDTkSSPAevR0zcRNvFv0Qp00ruL6FeMdoWYuEGc73dn211A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW0q7f+bdYfZ6UW9O9nE4jnBLGPymme7ddG04fft6V8bnxlgo
	i1nGfNIij1vi5ISJUlb+fXDHTXTA2kRBlIv3OmoKXu/EUOqJzR0uQsCP05CR6wlJHXhC/armbdY
	lpxnEfn85fPxKZze47aeTwBqCROf2iJj2crOwTcvT9cdI/xyhW/duAi32XFdS3HyvOPE=
X-Gm-Gg: ASbGncva6gncr+ndkswZxvG7kRbfQcW4DxDYtmiupIHSG3UyFl88dBUJjHQQZRqmQtU
	1C2npWGnLtB4feq9+Uce/BRM0eyrxlBARmxVA8nEGExyyUo7oLGDZBWTmFa8mZOC+WxC0Ozt4EC
	H3zC6gVnjNZZPFYLrd9bwqIhK/3WVRE4RECLoPjBdPKcM/Sg6SzJwowvxGIeh66tbyE/4S0eutW
	7bcMuBeI/4ZSLN4Gtq8zZx/xSisAH0H6oIMEEdgeu5KM84bXAQ9+8O4raksULS701Sq/UWIwsCL
	tdmXyrIBchAoyxhAp1DK2g+JwxLousaHdgVTOfnm+gX1r/8uUvDLWA==
X-Received: by 2002:a05:6102:c07:b0:528:95cd:bdb1 with SMTP id ada2fe7eead31-52b1bd1d838mr3723206137.25.1756821658110;
        Tue, 02 Sep 2025 07:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4njbxVQBDhMgFP+R+/C1mkzBd4r1t0DyPORMMUl9tndSyU436LA4uBfQwkstR2HtckVPx8Q==
X-Received: by 2002:a05:6102:c07:b0:528:95cd:bdb1 with SMTP id ada2fe7eead31-52b1bd1d838mr3723115137.25.1756821657123;
        Tue, 02 Sep 2025 07:00:57 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/6] ASoC: dt-bindings: qcom,sm8250: Add glymur sound card
Date: Tue,  2 Sep 2025 15:00:40 +0100
Message-ID: <20250902140044.54508-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXx/gC/niWeej7
 KN/OH8lW3d5AP8OHeJ+DCUXKlmefKuNz8psNsLT8W9DtMsx8+QQKgGX4sgkRrZxrvkdPG0P1uXZ
 lqOUnX8JfNCtW8IpIwMeWuKZLtTScUxTOdGb+1KmFWEnlJAhRdHDYhhaHm1y3L8TbmPbisQm1sx
 EJRoNp/OtkguRbn3kwTiNFAqk621nT4tq00r4/jQ0qVwUft7JnNNLxDvWa7TQhuUtOEz/SRMSGM
 Pt4XUE4AjVVANftOCKtc4NWigeleElf0E12/SQSUEqDzH3l3Tw0zmPoTD+1q9kNlZcwoiY23q2n
 C2wE9MArNHEJEx7+OQ6
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6f89b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MxEaA3INf6t8ycFtHZsA:9 a=zgiPjhLxNE0A:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: PVIHYePzJ8sVnU_0yJ_dV5hObiwB1Q8t
X-Proofpoint-GUID: PVIHYePzJ8sVnU_0yJ_dV5hObiwB1Q8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508300031

Document the bindings for the glymur sound card which is
audioreach based architecture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 5d3dbb6cb1ae..8ac91625dce5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -31,6 +31,7 @@ properties:
           - fairphone,fp4-sndcard
           - fairphone,fp5-sndcard
           - qcom,apq8096-sndcard
+          - qcom,glymur-sndcard
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard
           - qcom,qcs8275-sndcard
-- 
2.50.0


