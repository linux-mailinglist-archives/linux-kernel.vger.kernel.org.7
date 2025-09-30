Return-Path: <linux-kernel+bounces-837788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9CEBAD2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E07B3C3E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005F2DFA39;
	Tue, 30 Sep 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="uo99jEBb"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DC1D63D8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242756; cv=none; b=n2f3KM0qSj8h9T/I6k47AOzKirBDuQl/WNm5UnsU5an1KuBO3TYpIz4zSE5+gN3p74i+soqay8SzCXExRFnrgqbNViUhJfpgz6LrBefii6OxDAWgIUvHJNCozJNPYgVcx+ws7o3LRarLtKYCBfAJaLzTbhB284k9XAS9JNUaFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242756; c=relaxed/simple;
	bh=trtFIVQ7skIm+AJ2uSYPYV1+QuWRN+OapOx2C9yTkv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JhVkLMJ82KLLOPuE3zR+RvNgECiUnuUNX7RApwfApAZH4n9RF0QlJShYx7bpY5c0KsKgeYj9ZdvizRGuR30s+bieCIdmEbSBzIpzCdmQfHJij9sfoKnM9YojICMXkyrVrVbDplkrHSeAZ2kVTAtx8m1ftVNzNPU0G2u+7no1jFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=uo99jEBb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-634cdb5ed4bso7438881a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242753; x=1759847553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XGzvIYD2K0dKmTD5NLqz2HHH1fk0VmQ6ZCiFWN/CWQ=;
        b=uo99jEBb//E6n4KlO+0QKBYQJb6XRQl1vJxtpInYFxpMOYsa3pKkSd0e8ODPCrFxUK
         u4LIUE3V1hdZ1PZwH2cL0ArZnkF7BeSj7SJ6ewamd7HMsFI1fw2po+VACQJVKNYSz/lE
         LBPv7pWLdJ1/SCv+6MhCuPbXWNjoKsd6M4YUtTOnjR1xcNMABIb8c2eozGP7a06XuA7R
         S8R/vC7/rWCmEYBnpDwhTyT2e+b/VmpowgGVLWnsSghpmREeTPnva89w/bGAkuPXI1P6
         MjYHbb6T7ita6H7ydohm5Bhn0yJLbF0hAfoySuAjtzeNFNHI+x2pvuZ2kYxZsfI/AcN1
         10gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242753; x=1759847553;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XGzvIYD2K0dKmTD5NLqz2HHH1fk0VmQ6ZCiFWN/CWQ=;
        b=WaOR4/8PNDJ7MqRegZ2DpH5JGF63QNmTIGSULAoZqDdI7RC8U3n9LqmXORQhaZ/ylY
         xlPdkGj3MunW7LYnJ/7of/+rL132hl1N5y6cPJDNY0IOy32oWSbk/GDZKizcOIO7S4Aj
         RMQkSpQka4k1XiJXb94OxbfSXziRw+1ynsKrrlrn5z6eTW58+PUxkzzoj7Kc3o+iYtcj
         BNMqG8fWZ8yjAIiUWC/ZNg86exmchLSiU4QVSap7JYwrFwZpfHnVSa3TSqmhoOXjsZBs
         ebQXls/pvLBVqyTFgjsAizet+pEyhwSr0BhsKispIF5f7WKQ4abv1gUtxQVanASb2BiD
         PetQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp1W3ce/SwfDCf9ciXDyYgNQ6t8cQvhf3Edwl3Oty9K6TqILYlvYE6p7AxIlCmClWSkAYDEd14ZRUXh8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FnxiEK/M9361j0g8+ho3SkLXX+zYEd62gHI8+jIWNXE0aBI7
	addRsUVz5AF5Ze9l14oiWvTOHdFbx9QsbDQNUQnPph89aNx9hIRwxp2kiZc6h7Slplk=
X-Gm-Gg: ASbGnctmrn9plV5dfLkCgYsyzOVZfaEwIORLwXSf0kiZDkktAezP4n/s5hRaL4JZoaM
	0OgK9qHmR+XoXk5hh2qEE2PdL1TskvSmVT2jClsFp0y69T+feFU0VVd1YVu3Yn5TdEH5ost3Bd/
	pgJKeohB4V08e+2RaliJiehgGos+gKs4fIAdRe1AlEQw5R75UEZjrRenIS2Qy/aiTEhZ1WrpGqr
	xmSNoy9d4O+8YakYuGO/kYGnAY1jQzb/OPVxOdCAyUdYuV9oiigeFQ0kQd/6zIJ0aABEZ7/ZApX
	Q4GwhkQ4Iv9vZBIvCAn0ZLdaVt6yAEqSI4avImmuFisM92AVrYJH4fjq3chFdComsilzZD/uo3l
	dPmUraLFiLIs3MwvEHw4vzqu7JCoi2h4/sb7L9KXhEaRYB61mphi8806Pa8z3S8scjG+W3QnnqS
	O1iFnFoHdfhChfU/PYr3XMAXoRIjKy
X-Google-Smtp-Source: AGHT+IG8lOLegfuz9sdLqi92zTTH2vZJK6klR6+7kLs717bzPyf9qtgelOMxZ0NsFbtzUNaLIfkVwQ==
X-Received: by 2002:a17:907:d14:b0:b46:8bad:6960 with SMTP id a640c23a62f3a-b468bad6d6dmr66677666b.31.1759242753382;
        Tue, 30 Sep 2025 07:32:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/6] Further bringup of SHIFTphone 8
Date: Tue, 30 Sep 2025 16:32:18 +0200
Message-Id: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPLp22gC/x2MSQqAMAwAv1JythBX1K+IB5dUc6klbUUo/t3ia
 ZjDTAJPwuRhVAmEbvZ82SxloWA7F3uQ5j07VFi1ONSorxBItIkSzsxV2B7RaTNQ1+DWIPYEuXV
 Chp//O83v+wGrc7SkZwAAAA==
X-Change-ID: 20250930-otter-further-bringup-f9e640c4008e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Luca Weiss <luca@lucaweiss.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=943;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=trtFIVQ7skIm+AJ2uSYPYV1+QuWRN+OapOx2C9yTkv8=;
 b=qsGVrAkXP50Vge9B0Ma8EEFSVt6ayyjWaeKJa9SCVhcPnmY/baNqhqIzUOMWmIbK4rz7P3d/T
 7qL/hYgE3JQBqzQ5/ScU7vwrY2Q6i2+N8g4TaFEEZH7Zg0usT7M/IJ+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add some cleanups and fixes to shift-otter, and enable flash LED, RGB
LED and Venus.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Alexander Martinz (4):
      arm64: dts: qcom: qcm6490-shift-otter: Fix sorting and indentation
      arm64: dts: qcom: qcm6490-shift-otter: Remove thermal zone polling delays
      arm64: dts: qcom: qcm6490-shift-otter: Add missing reserved-memory
      arm64: dts: qcom: qcm6490-shift-otter: Enable venus node

Casey Connolly (1):
      arm64: dts: qcom: qcm6490-shift-otter: Enable flash LED

Luca Weiss (1):
      arm64: dts: qcom: qcm6490-shift-otter: Enable RGB LED

 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 75 ++++++++++++++++++++----
 1 file changed, 63 insertions(+), 12 deletions(-)
---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20250930-otter-further-bringup-f9e640c4008e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


