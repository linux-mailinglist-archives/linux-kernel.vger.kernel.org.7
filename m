Return-Path: <linux-kernel+bounces-871273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7EC0CCA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA24F4C27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559742FF17C;
	Mon, 27 Oct 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b="rELC9jEG"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E02FE07B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558704; cv=none; b=jbA3gWMTmOj51WkfXt4FG7GFrmf1VB9aTd3ic00LVsLsYQ16tbkn+1fPFCakq8R07osjzWcl78fePvsG+jcfGGVKUDkH0EO/mXqQ/7BHDvf/RYp6qNxret1BWF+84HHO9pC3j3+UZBlh7SPlAOUQHdx5d4X/RTXS0JLwnF5VLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558704; c=relaxed/simple;
	bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLBJpEdXk7ghLRwrCgtR/gucrMfw0kbOfQwK400sB/N9103clM76h5Pjx/X/z1Ll1DhSCclVxPtnAuL5PYFODPawu3krIGlqWC0+ZTNIL2Txk9IBY6ohsnf12z0PfZPt5kTLypXYqvXz1U/KfEGb2N5+9skRF/kJb72NE9HWsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr; spf=pass smtp.mailfrom=42.fr; dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b=rELC9jEG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=42.fr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso3222876f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=42.fr; s=gw; t=1761558701; x=1762163501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
        b=rELC9jEG7KjBUI7azR6Cu2uOJaUcWb7iz9nEthoDoAVAxxXGUf4dettBZmUYRF0o7D
         b3K6ZWw0wIXLGCdqFP4w1rd2PKCThb1+rnEwUVO2iIIaUl/fHbDXsq+RWsIs01mXurSR
         2BXnJo42IssiydfJYcKQbWrhtJUf8Eh1+lGCLpNii9DaspRx/UZIePI9zXN1s8D+eyAO
         Zn8iS6OFsK0oZGBl0p2J22beOXhu55g5ndj+zuIZJCSNHIzwxHcT4cVpEHC47RKIOgJx
         Uh1H+wzYYrWkTEQimDL4SIE73mfo/wBimJ8EVbXubaXzB7Zm4c88zhhM5HJz5lasCact
         UJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558701; x=1762163501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho8xn5k/6fWo/MTrNIO/VG1OI41Us+9e9ERYp+B3brM=;
        b=inKn1RG5azYDjyPNCZwVTAwOR426gUZVtJrG900dvn7+BjVkPHUcWIog3389OVGyue
         hjOiZ+M225aD1kvugxLnV+JYRO3nYdzbPtA4bvopYY5AS5vxZrmCLm5LkZj0G1mEJ+VM
         oCmMJA/OEs98JkIt5bVjg9bhAeVb2EFvyAfl4j3kgEE4lyc1QxeHOx602o8BNHpvUWgF
         knxTm1ObchLjkovavQvBcsPr/xcw5bXTpr7rlueS0zIDJcShQKW25s6Gj+ykSRNn7y11
         vYRMm4lk7bZ5IYFJeOMUQh8e6ffqjYpPqm2RnEQc0D7EyhSEoHvV7WWCNa91HsI0+zF5
         JKdg==
X-Forwarded-Encrypted: i=1; AJvYcCWYUvZF+E3IPeMzfoOeES8nUFSNUfjfhHM9K5yLdUVab/tIeRa7AJVZy0Gvbsm8kOedPXWWrweN3ERlf58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEWZhGe/F8jBwwjWQkgSpFIxSdeVAUzdS12RvJ3bRqSrJQ2I3
	hH4UDAcqgmkBQQxg7v59QNbNaq42uKxdx0wk24Fd9AwWWyMDtFqT0IvcHPXNb4Nc7xE=
X-Gm-Gg: ASbGncsGVc2uQgCotU5DeCJKDF1mGwjzuhULsaTAymm59Fhv/62SNeFaPYiR7JUlsSZ
	YBVdr1QvvNHse05kDosJbgFiHddVbZzzhZPn4XdV49tSCM0YPkPvNshzDzTO/GOgscgq/A237b9
	lnH4XbbggRQjXLiVuHwqE4Rs0t7TrUZ7//zTay1gJPh7YFH9Q6cTTqhHQYAskVPqsUcY9S7ESlW
	fDbN4pot6zlyZOnEznEMz3yJZC8WW7IevosOyZkTt8eMLe/wcSxkzoDAmknet+GCLlqcaSehn4E
	hrvC/Le9V09Plxdci3I+bqxsI+gy2IQ9DRahy4BthKBJxKPcpxZL9DIOjDqLI1kR55xHesIIPu/
	/ypIVX0UBVVB3ptglP/GR5Nw7Okr2lW24vsGt7TrP2FhND5w+ZLnQytf2DnAr6IFiUoKnElD97E
	oClqxVMsGzKL8=
X-Google-Smtp-Source: AGHT+IHBkoxPxf8kqFm1f4QYWTa891H2PsAiwWjxVPRrmr1FmGXiod383Gk6kRODuBEd54f6Gl7K5A==
X-Received: by 2002:a05:6000:26c5:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-4298a0a8eb6mr10250190f8f.32.1761558701224;
        Mon, 27 Oct 2025 02:51:41 -0700 (PDT)
Received: from wow-42.42paris.fr ([62.210.35.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm13125062f8f.9.2025.10.27.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:51:40 -0700 (PDT)
From: Paul SAGE <paul.sage@42.fr>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mchan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.sage@42.fr,
	pavan.chebbi@broadcom.com,
	vinc@42.fr
Subject: RE: Andrew Lunn
Date: Mon, 27 Oct 2025 10:51:39 +0100
Message-ID: <20251027095139.399855-1-paul.sage@42.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
References: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tg3 currently call eth_platform_get_mac_address to retrieve the
MAC address from the device tree before trying the mailbox,
NVRAM and MAC registers.
However, this function only retrieves the MAC address from the device
tree using of_get_mac_address.

We are using device_get_mac_address, which use fwnode to obtain a MAC
address using the ACPI, so as we understand fwnode is an
abstraction layer for both the device tree (on ARM) and ACPI (on x86)

If true, it could be appropriate to replace the call to replace
eth_platform_get_mac_address with device_get_mac_address. This would
avoid running the entire function only to later check for a dummy
address.

Do you see any regression possible with this change ?

