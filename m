Return-Path: <linux-kernel+bounces-813166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D4B54174
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47261C82C97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10D27467E;
	Fri, 12 Sep 2025 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqMrXJvD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411D26D4F8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650074; cv=none; b=uV9NQRe/WZj57r8MWRViitsv43cVBKlUvfK5Rw91tUzji8ZAhAVNlpK+bXQVT/zRKgIbtCk7/71M0znoFAPUyfzWagtzMhlfEYTQVX0QObdG+i+xL0RDkSbf/Sm2rBMXFpu+cBL1zhiaOaO59l16PLx8z5LCEBlEexXqijCObVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650074; c=relaxed/simple;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSFfmuQjG3DHXg8MCHgNitsNYTJP+WLjFVceTVHpU6FrcJ9NSB7I0qN87yImy1YG0WFa7qso7sW+ykJmj7Au6Q4h3wK0ifzBZglwLjB/SfkiEH04UMhT0qCvaggImc/FiXzFd370zVR12D/3zgwuUvR7BPWoKP93p8TGxfSyCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqMrXJvD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BK8WO3031134
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=TqMrXJvDnndTHE8V
	cdwpRbB7NMB0Uza1PdVqtA1sHoldiQ07zAcyYHo3s7661dkj8pj1MPfX+eDE79oj
	tsvYh/G0xeJJnhUxmHuCLO4hzWvP8BgITilhMfSL5Q/23TfwqWXKjZngNcSnYsCH
	azw2ZMTjSeDkWvbef0COzDWFwVFYpBTPumj5KpxRetgAGkBGsu+Fsgh1pNp6BwLZ
	yo8jLYDSOMR5VSMPnQnKDWhhd64PgQIdlduHN6P1KyBgdR9jv7XBH012MgKg/X+w
	90f6jtIBkn+JwuF/KEs8/JbZ/NefXQvm1XNbs2I4wCPYfM6akRUAZW1TRIZJ4zZw
	szBOpA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg9x36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4d3ab49a66so2080119a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650071; x=1758254871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=GSUZ/pY6HgMq1qc39QpwZuZpHsMqKOgdNAmQKidrNYRyjEBoX0jWuLKmi1ef0nrCYV
         a9hbyBcNbWtLpLCH0E3ugkI2WV/NXKI82hujsETOSnxWSwGVcuBjOvQg6ILkTMz2Wgfg
         xiJq6uB/0ZBEluKWkfl3tieRvakqxnp1Zb4hTIo6YJqq3BclaQ9TwrLIPKqfPJ1vQUHB
         OnXbGdZp2RGwjaI0cvGM+EWlC3/QJKjOnIO/y5KGE1503zUd0C8nOcRw4DxGRtacIHfz
         kqBJ5rD+uFsxziZM1BnMMWxY0VXXeEKd526x6zpbZfAvnI0eZ/ks09Kl7+6LeoHcYhAS
         Lusg==
X-Forwarded-Encrypted: i=1; AJvYcCW3DzW6MEnQPDyhW1S1cu5L49+OCuAJWTMw85DRJ/SS+WLb3bmpcQ/nS4NGwp9fT/b1n3YKlq9WetUfDsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzETKrujxfNV6w7S7lhJMejBPvc0TgteTLod3q33zrGq7mTuNrp
	h7JR97ygwl3h5Xx+VKCudp7MgL+X+A4We5VjbR3AtgSXFSMd3SDYpWj+i+DPv3xf4qMEp5wsuYL
	BPeQarO356U9Yrt/diESYBy9z8fFO31uwfhCgvKUNUHoUo1O/YiPllU765GmdrZgYOQ==
X-Gm-Gg: ASbGncvivjCPyek/iXXhqgH46YaOd28AAEWzctVA8ZmFz2zooPE4ShxX/cw5vsebFb9
	S/MLts+p0F25GBx5ezGJOAj/KDv6LFtJOvSM8NJVnR+cg1FI//8tzzbJzcu1qAvRvk4tYCDVRZd
	gLdkEMK4F0jhSDgvcN4/h1A2xn6coepYkqgFWuEo7p9HLb2NXgRY1Rugiv1Ko9TgiBhLimq6hMC
	jVi3aOFxPeEyJT3SqAmIR5tBGmovLMEF8YSSM+e3rgVfsRFEPpmV8mJ+KcjdvXYyQUNLew+s6My
	Pq1LodZ1cEkxYts1omaNV0pSkpZi2xbsLikuRjoQP3v1cPwOa2yAa6wLQ2PPwLhEFa/dwyY2b7l
	6C7CkjhXfYfTTurn8fzZxtyQ=
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317685ad.14.1757650071308;
        Thu, 11 Sep 2025 21:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoqJc1O/uAlEAxgaKcABrHUnAHQ+NKSR7AY913bzR8AUunHyu+K06+VfdNdepa7qcmVz579A==
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317345ad.14.1757650070858;
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:42 -0700
Subject: [PATCH v12 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-3-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: -c-4M2ChTA3g7JkqHv37RHANGC4Vdjul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXygsjZgKomz7+
 NGmFirO6ncG4rW62bGeltuFJHLwfGNZSUW8eAUs7DwddW/gEo5a9We30yYVH4ACmsBYpRJQhFl3
 3/yOM6Ce5ELXR7X2VeNnQ48ppOAK5T20J2jI6D0mh7v4qeASup+dhTkGWD9cyuYM9gJDXgTw1Yr
 NeZdDJ8oQCMorIjskgUp4JYo/FHFcp4JW9nREN0eOLSuRUomNQkuf5lz7A8iRsixgfKIkfwH/RZ
 zZVLtUOr6I/Qkj5z1JbHb0w05w5tvVZv0nMcZyY2v4CC/E44lKl+qXrLjoWzqznZL0mgE0Q6laI
 Xq5ukrtn8zyLgGeYLO2Gpn6qo90uQsxAdbKIz5qDb8B2Xkqqjwf+c6xlsdMVBzuY4/cSQzRCFua
 p6JyqgUr
X-Proofpoint-GUID: -c-4M2ChTA3g7JkqHv37RHANGC4Vdjul
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c39c98 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 807317d7b3c5..9fa042d80622 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -926,7 +926,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


