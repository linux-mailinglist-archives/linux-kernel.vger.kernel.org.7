Return-Path: <linux-kernel+bounces-884673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4337BC30C04
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55493BAA1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46882E8DEA;
	Tue,  4 Nov 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIY0BO1U"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4B2E5400
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255978; cv=none; b=qdHC3laDbt0S9EtthFhK2HzD2GM5oa6y/WUVFxW400hKxDXzlkJeoFaeegk4/IE+/4ocMlmcundWWcV1DvU7YGCP1jgjwYw6y88ea6rxrBoCymjbz4KC1iv2y+ICZOGm6z2RR0yDs/uvEbmfwcqKmYQrQdptivLFjyS82YIlq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255978; c=relaxed/simple;
	bh=K+7xZU/4fUasOYP9w08Q3aQyqV3Y0UA9c6Cs+oRVkwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHy+Qw1C/vzVJKd+UmYGUlmLGrsgsBpDP9lTUhkOfLnMnLVX1bEmqrPKtf2ovCkPupm8Cpm/yPKagqUrPzplsnBu0KP9w4zs7QUSe0jg3JAS+/THN2pGrycFbpzjQ7RYzaNGZnTyRfJGvtHw6fiSSr3uqTLF/k+OilOo+5ijDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIY0BO1U; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so1173295166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255975; x=1762860775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ercQmq63F0fbxCEEluw3pSTn/eQ1S3fyCo/09FggsIk=;
        b=GIY0BO1UvRfXXoisrWacXTS9R/KKr1SOaiIRVCTvmod6kBZHOemAL7DB36cIzkgeoG
         W+osx+Gpptn3ejGTFV8YeIgl6c5ovanSklQ2oPoXcHlfRmsK7y8lVGrBW2LybJcsUhIj
         YmlhBDb19bX9A0q2BdL6MNeaGGF1MN9YCzJoSkCea72oXhAogsP+qMzQf77j88zIa41t
         tXZbdQ/F9jyzd3mHnu57cKvvclxdgWxm2z9wBqgGWm3ITFihtu3XnQUJ+ScwjF/EHPcP
         p9NdTsqBqWKdTgdIi/6ZuEfP2rT5IeAYPI8ytax0HQ5JtL5GOUdWCfm45UEUyylJCXSf
         ImFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255975; x=1762860775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ercQmq63F0fbxCEEluw3pSTn/eQ1S3fyCo/09FggsIk=;
        b=gaHI/Bl56hGj6zRbIcr0bBSP6rlDwzgwGadhOwttV2OIsny748XLnXLRnEdElUrEqh
         AT4YcbTfPzS2skH/BC8awpd2ANZoiJS7lVeXU53bXrpC6HzL2U9vD8c4GMK5/eEaitu+
         LKDedDvDMsihgVEY081elQ5vIVo3tTCArOzp+JUL6PcFzwMmnTQai8Tf5zC3xJfwfbFT
         s8BSdtKQ+7D7ppDSPomZXD4x0k1X6guH+4ox8l9zJ6CXaN+K064TPZD6AqMGmsnL1sst
         O6QkMmau9+LQoeYskXL4vFtGou7x8v+aGeyI4+ZntPNDNtx/76Z3N9BnIfDbCnJUTQn4
         Trfw==
X-Forwarded-Encrypted: i=1; AJvYcCUE0t1+/zpEjYlyXcz1lTdk4tfCd6EZOYTRAnyDNp8cgD/ULcDHfkpaeAo8eBev5BbJAgAfov90F/TItbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32f5CSGkHChm8yU148kbVL8VpoYNg39UeLrT9VqudPbSybgZS
	xMuqvBZ+fzDaGK/UQDGqAfGENGeYewCJwI4pWSk3ycvdMOWzYgXPQG2stTBfR5zGxz4=
X-Gm-Gg: ASbGncswLSVQSW/chxJphmPYcw3Nlc/htiZDhi8MvEFAlPzVM62gD+//7909v9KPlw7
	XkS+ebufQB7JtlvKkxoSICXfUf/uyv8r3prFq4ccHee97cg/5K3VVfgY+uuwiaWxIYNYP/X7H4a
	LpywaPo5ttnpKE8Wjf0VrjZrREcivSoBqhNU++d+zNFhmhA7Y5V+0FlVEFgpTnSOlnH6hfb6csI
	n67HhkCoWgcCx2ZW6VSOymhT7j8jgI9pcbD3DVLGtCk4+3vw7SYgKUXQAfxOpaZqW0VjFeBnz0E
	FSBd5nvOQJ7FwgVnvz4uUaxhm0vwgqt7vDEMpyG1mSQ9QCoG7N84FVgj6qU/RstA/V/GLAfc4KH
	NIE8aC/SrwGz9UMXkuN/QawzdA4RfVzjojqmmpTOyrprSZQe1C3Gjv4ywqvEFPYXmz6iWamdnMM
	SSbWZzQg1jXWEib0WVSLpo2f//fXOtJD/VNcrR4TDYxj1gzOqL8i9WHQLUM5E3bw==
X-Google-Smtp-Source: AGHT+IEKD2kGOugAAAnbCnLnoC1UUvIAOZG3fusd2JbtCMmNYg4W7DiOKZH0QVR7QvG88atv4rcCFw==
X-Received: by 2002:a17:906:9f8c:b0:b71:6da6:66ce with SMTP id a640c23a62f3a-b7216900080mr354590366b.18.1762255974644;
        Tue, 04 Nov 2025 03:32:54 -0800 (PST)
Received: from jale-pg.. ([2a02:2a40:17ee:2900:8627:17a2:2166:4084])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72404470e9sm182469766b.70.2025.11.04.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:32:54 -0800 (PST)
From: Jakub Lecki <lec.jakub@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Lecki <lec.jakub@gmail.com>
Subject: [PATCH 0/3] usbip: Convert vhci-hcd Kconfig related to number of ports to module parameters
Date: Tue,  4 Nov 2025 12:32:45 +0100
Message-ID: <20251104113248.223594-1-lec.jakub@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In workflows involving a greater number of remote
USB/IP devices, the default number of available virtual ports may be
insufficient, forcing user to recompile the module with greater number
of configured virtual host controllers and/or number of ports.

Allow a user to configure the number of USB/IP virtual host controllers
and number of its ports using module parameters to simplify the usage of
this module.

Jakub Lecki (3):
  usbip: Convert CONFIG_USBIP_VHCI_NR_HCS to a module parameter.
  usbip: Convert CONFIG_USBIP_VHCI_HC_PORTS to a module parameter.
  usbip: Limit maximum number of virtual host controllers to 31.

 drivers/usb/usbip/Kconfig      | 21 ------------
 drivers/usb/usbip/vhci.h       | 42 +++++++++++++-----------
 drivers/usb/usbip/vhci_hcd.c   | 59 +++++++++++++++++++++++++---------
 drivers/usb/usbip/vhci_sysfs.c | 18 +++++------
 4 files changed, 75 insertions(+), 65 deletions(-)

-- 
2.43.0


