Return-Path: <linux-kernel+bounces-723479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0EAFE758
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B477A7431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA31DF74F;
	Wed,  9 Jul 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="p4vwdbNm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9000291880
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059603; cv=none; b=lsajQw1+vfs5+L+H3fjeFzQo215JeA2MHIMhvKu2wB1JYa7Nh1fJNEEYY3fTp/3eVau4DDkL8qNHTjtiogUu/4su/VI7fXraGzFPrS63R0BNGAVmeQTXXK9qhXnyHwogL9eUnh1OFStSetIXbWh44aL7R+kmKE51XLfbg1vFo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059603; c=relaxed/simple;
	bh=KmmXb3IGW58F4EYW7Gl3SaLFXPNaUzU3JQDJ5hBWE8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OtdtjCON8fLEF+iv5jklOS32Zqo939hQAQ2Zwe2odb2zw+NhFQLyOqZE8I/WwSuY8Dn9MsPWKkStkygXpIwDgARAt0zZruEBVrRp/pylhjXPGqMCjgYjqVSlxxi6gx/4vt6CfSMXiBsKn5Sk2O0C1Gfpf0znyFeFnkdQuHwZ7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=p4vwdbNm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so8097524a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752059599; x=1752664399; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGK37SR9qg+mqCt4whATIIAp/+XzlTiBnwS50eY+IBo=;
        b=p4vwdbNmRBhhCsmK06v1IGoZd8oWiALu0lzzJj0FPOe6/XkinSkaTiyfOP7o0d6QSz
         izYggpYwtGT9l3Ox9fXOks35M/QP09liEiwb7xtfP0E+cZcoDXmQwpLhKn4CBG6gbTsX
         NUkfvAKwrmd4rw1yaSt+d9Dks7NbersurvO+rFtPRHgK0UlIQDZAHm+clZ+U+Rc3Av/v
         ZsjYa+hkoAQjpE6Nc6jjL8rv1HslxIP4LNJMxO8bsADjgAlkNGmj4RdyUyChIwdAec/J
         RBJ9loZgvsKk1GQPRA4nfEZMxKrRZKPnRLSc/DqtDfd3wHW1EPyEPp6lDjdzsT6b1IqA
         4SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059599; x=1752664399;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGK37SR9qg+mqCt4whATIIAp/+XzlTiBnwS50eY+IBo=;
        b=oXiFpOx5G1qjn6tH1ytz03Iz45tbUIe480yxnFEaFxMuLDbkhHMhGGs9zpVBZLY22s
         xvdMchCE5Ffrg7NOMBbT6m8zZhcGc21DhKkPHE7ve1FO9IZ2JR1I4l/+X13pleWLZK7Q
         OwzFuiazS3XIpXoVe9kgDDgc6M8MZqYlFoeRJauLSQXeT5jHUS0+JtS74hu1zciRV1dA
         sV38uVWE/A6znD2l+1ELOTH7TA7OaE1di8TsbhjP6tsqv+dJMM9gaxLagREVTO+vcO76
         FF6R7YYk8tmyI2pMneVLTTWmS08DDg3Yh2/mYgzf8WLGaIHitUaGzDrXNMo3KXdNERhj
         k7iA==
X-Forwarded-Encrypted: i=1; AJvYcCW9f1eMKekVywRUiv2ta0l85RjkdRCi2+L1fY0BiBvNzNC7wkZVaEpeUCV9yCJ/uFV5eS8ZHCwU7gIUKUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4+JbqboCkvgAZkrJff0OI9oxkqHpvYSKdXL+/hGO+nNXEwv1
	hhP/kJwikbgLseariqP5CDkGgA5Nw/xcW+faQADphVd79fUVdtM89j4iBSDiNlK0Xys=
X-Gm-Gg: ASbGncsA02ENpDTj3a3kWYbHK0akExawwHFQCqJAvDYI94DH7CgAC1I3/CkudxiN8zg
	//yu0QruByeweDhrppxBWCjzgtKnnG1AF1DU9CnzTI4HrL0EoljkAh0tB4fKfbOmvtoulSY+BeL
	UQNOh5LzQcv7pUWw+2wangiSz6H+7CJkGVQ4ph1vf7MAOjw4uu9y2efnyUZgB0Bnm0eMTkkT3as
	w0MZdGaOdFoUtr6ishHVq0AGY2ed28i1urI3eO3UfdzzSooL0sPvYPZ5GEfwtbtfp6lgehCqIr7
	9N9bM+/nVZVHRW15YCz8VXHBTGh1a3btEQDreMt6pBQ8wIhEW3BNoSxNRWjk350EbrKZDndYupi
	Mq2AYUB6MwAY6Ed1E/3qNtiWF68lokwa7
X-Google-Smtp-Source: AGHT+IHp9TcPLQmc20T7xVbbGWJIvpTGAkt0LP5/ytEl/Z6MxQQcC47ryedmByXsGf3LPA9gfi8oRQ==
X-Received: by 2002:a17:907:12d0:b0:ae0:d4f2:dffa with SMTP id a640c23a62f3a-ae6cf591593mr163224866b.3.1752059598963;
        Wed, 09 Jul 2025 04:13:18 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6daed7d49sm27191566b.114.2025.07.09.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:13:18 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/2] Add support for remoteprocs on Milos SoC
Date: Wed, 09 Jul 2025 13:13:06 +0200
Message-Id: <20250709-sm7635-remoteprocs-v3-0-c943be976180@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJObmgC/23NTQqDMBCG4atI1k1JovlpV71H6SKaSc1CIxMJL
 eLdG4VCKS7fD+aZhSTAAIlcq4Ug5JBCHEvUp4p0vR2fQIMrTQQTkinBaBq0qiVFGOIME8YuUd5
 cnFUNM01rSDmcEHx47ej9UboPaY743n9kvq1fTh5xmVNGdc2caiXXHODmbcCpjyOcuziQjczil
 9GHjCgM81Zy403rlftn1nX9AABrd+H/AAAA
X-Change-ID: 20250620-sm7635-remoteprocs-149da64084b8
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752059598; l=1151;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=KmmXb3IGW58F4EYW7Gl3SaLFXPNaUzU3JQDJ5hBWE8I=;
 b=BFlJHfIFdwZNkCcQInWTPJFGa8OC9zQO/qCl4TGtDIRqZEYzwxhUdEUp68M0bVd5J0M9KrAmw
 wgEjAlwrq7/DlUOVrPHF0LNqzEMtwYR4oUrLlURJDy6FcrkD+HRcNC+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the bindings and driver for the ADSP, CDSP, MPSS and WPSS on the
Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Replace additions to two different bindings by one new binding yaml
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20250627-sm7635-remoteprocs-v2-0-0fa518f8bf6d@fairphone.com

Changes in v2:
- Update default firmware names from .mdt to .mbn
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-remoteprocs-v1-0-730d6b5171ee@fairphone.com

---
Luca Weiss (2):
      dt-bindings: remoteproc: qcom,milos-pas: Document remoteprocs
      remoteproc: qcom: pas: Add Milos remoteproc support

 .../bindings/remoteproc/qcom,milos-pas.yaml        | 201 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |  24 +++
 2 files changed, 225 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250620-sm7635-remoteprocs-149da64084b8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


