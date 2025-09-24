Return-Path: <linux-kernel+bounces-831452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87599B9CB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F38116C121
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABE25742C;
	Wed, 24 Sep 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yj3FZfxJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C0611E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757605; cv=none; b=dCRSZRVyw5/oFYYRXPY6ECYGG8C5Kra2PpW15w6mY0GTA91Caoj4CXNAuSy7TiZv7Dt9OD5+wmRwzhwn56vAJXE/+EsvLrQsFJDdMgyO6LErdQhJNeIoNLqIpy+xlyQEjANq8PnqIbUQoLkMKplZBUPo1U/ncyESn7au0EAVB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757605; c=relaxed/simple;
	bh=j+o1N+A6cz4DNX+PHP8QLZuXZ4/y6YVjvv721Z3nnPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ggLgmustfnQvz+HRTsp4JQdtjQ9m8qEXlWAwrDORqi5BzjkYjg99rXNNJwHiAFLSCFbEWzlrOZTDHKrqLIkf7f84fK/OJU9nZaqujrsdIfDYI1FQMUjqfu+UpWF4yn8rouEUS33CF9YM/aGnPeP6eupMhtFNnRB4NlU2gvhXO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yj3FZfxJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCq7nW020897
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Dkr9LBIM7L/Tb1+wbxP+5Z
	hY7imalm4QZNmOXTdv8NY=; b=Yj3FZfxJh/3w0j8KbM2OpeHpueRIM/67jVCOnE
	tHudpFDdhzm0G0Ip0xDdRIV36cY2vLgX6H9/zDyAgxMMEWeDAnLLkcgwY2Y5TGPx
	D3RutdbNl2bp1msAqrCSJtzj1Zdb6k1H6MfozpqaxvkZxKU6aq2tCZP6O9SIG/fP
	bIcOE3MxswB7z8bI+rg44W16etGp/ewW/4MkD/xdbiI/GgcH6XFamLGOzmLUBNXF
	mDRJgE3wTZwcZAIJQPQM5N4AYIsgw8fcduqQjslbo8YtKmpaQLcXgbwkOfT98oCK
	zBpwUphMxh4Gqkn3DSd1uInBG1G/Dwyb1KZsaA4L2WZoe85Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy9y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24456ebed7bso3480935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757603; x=1759362403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dkr9LBIM7L/Tb1+wbxP+5ZhY7imalm4QZNmOXTdv8NY=;
        b=H5iv5cmPvMjWJ1SD4aYt4f5MbCRnj+1H6oawBu4THuII2UTU1PK4DPb+NVI/zDQL4t
         iqWXV5sizuOgSyJobCxC8qctAyltu0rHgnUqfKKBJkxNJeerhymLtRmuEg1kRnyrijAm
         7yD1fkVKAEjrqw0pTW3MGhgASY8FBvr9Exc+Le2+rfe/FirxxlLPR4tIYLFDaDnuJJmg
         k1BhPKngM3rnZJZmDcKxp3GybzZghOwbL5Q0i+fO+1wqFxKiQ8EzZTjCRkqb5oRLYm1o
         GcpMo7/A0GQbtWDm9pjC8f+/GORIKVyxadAXmlprqahS8xKVquirGoIXvxWyN53FffFY
         VTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBr5oTjTtwLCvLQURgZOW7mW2RxHkuy+b4dO0H8vjgBHXo4SU9++kWUAadJCiUgbejSNvrjltw/NJP9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyziZiJL13waXVRPuJOsbLfIRda7XA/ftzsqYTKcRobYQ9mjd9t
	Pyu5HTzezz2ltpAlVCj8OAayHBYqN2XCon7lNghunDKcRFOXaV+t4FYovz+FzHz7BVAUXaZLXhh
	57e3/a/AR/NhJbK0eQBBA4rxypEvtO3HKGDzZCnnF7sC9HOfyHBl5omSLe+/9HdzJtE0=
X-Gm-Gg: ASbGncvtgQyiXrDMUFzIaNtJiW83wUjDzdjBiCMxShm7qHx5VrARX0rGfc2g0UskSsP
	hZYqp2g/eiDsaRlW6TPUuOoj84k5sklXvLzCTBs7/W8pCladqMM3J/l4INy72YgTM4/MOkXXDA5
	3B0MDwjVjkDtK30ygzLQiGQ0KyrXmY2ULolkDU6QLLRoMJp/lpxYNol188SE2ZvVqIz5q9v3OON
	wVH/ncarPLz+ION8YSfNA8A4bdZERgkIY6xKTyyndzFHWaSRgFhpmZnhcAGRMHor1yq09x4jQ2/
	sfKkKwQCfAjBSnoUil7UNAK9q+6UdK/IYHrTtqawfwS1f1HQTCNGXg6JvixAsSxc5GKJA5jfYDM
	YLlugu8mC0GzCPr8=
X-Received: by 2002:a17:902:ec85:b0:272:56e:e296 with SMTP id d9443c01a7336-27ed72a466dmr8014985ad.30.1758757602813;
        Wed, 24 Sep 2025 16:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMymjaREBsLIvKLNW+Q7vB6DhWGdnvzEkvxiVNd5Mt8P3KBP//WZcxe7JlYHiq3FZD3j2kVQ==
X-Received: by 2002:a17:902:ec85:b0:272:56e:e296 with SMTP id d9443c01a7336-27ed72a466dmr8014695ad.30.1758757602323;
        Wed, 24 Sep 2025 16:46:42 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm4318405ad.103.2025.09.24.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:46:42 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add ADSP and CDSP support on Kaanapali SoC
Date: Wed, 24 Sep 2025 16:46:35 -0700
Message-Id: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuC1GgC/x3MQQ6CQAxA0auQrm1CAUW8inFRhiKNcZy0xpAQ7
 m51+Rb/b+BiKg6XagOTj7q+coAOFaSF811QpzA0dXOsBzrjIxec2d9WEjJ1/XDqu4mohSiKyaz
 r/3a9hUd2wdE4p+X3eEYmBvv+BUpq7sZ2AAAA
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757601; l=1302;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=j+o1N+A6cz4DNX+PHP8QLZuXZ4/y6YVjvv721Z3nnPY=;
 b=EmWcrgX4X8FINHrxR1Fmsl/nVUiOel88JAClsPVDeVGdbyZfFBF/h8NWT/Ts00OBJxkBCt8/r
 1LCxMua0IJBC6ABjjncQERh3jKdNcEX02B1At/cAu63tz98ftIfJ7bR
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: quuA6NMqE-hVSg2YneeWH7hr44JluLAc
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d482e3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cuHX0V8jOqVKnLf0s2oA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: quuA6NMqE-hVSg2YneeWH7hr44JluLAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX+dxtqZ9hu+Ve
 n/wF9W3ZFmB1i/L9lJUgmogVJqXddy+N5aHrjWmye/LkitxYlhotnLOmgX0yCLMUUoq6WrvKju4
 HFG6uJl71oGZ9DxMHqYBLlcxSU7eHmep9vk215pGgRr+lskTw27pzHUffDf0+FyFeuz15Sl1932
 ys4inDZnwsQrP5Rj/ysh9yv5ax9YXU/GZeYI2xJNJOzXef5IE7b3rRlr7AKVpMh5mguJbQmhV0Z
 9uLT//9veFi0CvuPf8As+4/g+xTj+3mwrY0tbSkwzBzWsrjN7M75CTBYZUC4abFhkck8lB+kt/y
 jndEQjmMH6EAa5nH/c6XTmnoQDEyRMYlRa2ixVoJYwNq5sUQ6moNwCBA47Nw5AyPonMsbJFtIFC
 rRs6aEg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Introduces support for new DSP IOVA formatting and hardware-specific
configuration required to enable ADSP and CDSP functionality on the
Kaanapali SoC.

Add support for a new IOVA formatting scheme by adding an `iova_format
flag to the DSP driver. This flag standardizes the placement of the stream
ID (SID) within the physical address, which is required for DSPs to operate
correctly on Kaanapali. DSP currently supports 32-bit IOVA
(32-bit PA + 4-bit SID) for both Q6 and user DMA (uDMA) access. This is
being upgraded to 34-bit PA + 4-bit SID due to a hardware revision in CDSP
for Kaanapali SoC, which expands the DMA addressable range. To support CDSP
operation, the series updates the DMA mask configuration to reflect the
expanded DMA addressable range.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Kumari Pallavi (2):
      misc: fastrpc: Add support for new DSP IOVA formatting
      misc: fastrpc: Update dma_mask for CDSP support on Kaanapali SoC

 drivers/misc/fastrpc.c | 86 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 10 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-knp-fastrpc-a1479674d113

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


