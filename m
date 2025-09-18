Return-Path: <linux-kernel+bounces-790671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC610B3AB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD981C86567
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1B27F4CE;
	Thu, 28 Aug 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SM5oRAPd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07927CCE0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412717; cv=none; b=kclKygtQOO0XqmtYQorTqWcENeAHFHnfxV5yM1IQZKMki8YC0Myc/a4u+HYS/c49MhpM2YoRFW7oC2XbCRHcydgYnvESGGEJ2adfFaEKYqjSH5wY+Qs5FwBALxVxgM3SvonC4ffNyzP7CzhWLkoyq6CFhkkalgeBjViieAqNgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412717; c=relaxed/simple;
	bh=fJ/sO78lvastRjtDt7P/8+A5rUoYFt5ky/4sBRhvjzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U24WS5OvIJMrnVzF22NI5Y7pUbGta5gcAGYc+Q/+HuCqs3CzlmCzAR7hKVyplualjR2tdZh5iTcRnMbCDLJwiynQorXEN9VLcAix//5JtFQvW7f8wZfiUvTytsE+lVhUTlEi44TLtSkOG0hxfCYJteZEpKyN2RNi3pKD8XmxslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SM5oRAPd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2487a60d649so16331345ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756412715; x=1757017515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=526DZvOdfFdWnRr7VLIYoJ9rOuKdtRXZH6VtJYFQMAI=;
        b=SM5oRAPdb4N9ZyuqKMIikJgwuts6HrgJOAhatf62APCwHaHn2B5aYfVH54w8jWl2pu
         sxyG8JNWKe7wWJuOpF2J9g5rnbDmlM9z8W7pKAbm+BTaVYPl3xCIZkAMyFRB7VDG4TZo
         FgLfGE782LrJUPPCk0sD1bOfOdXa/DCiDLPg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412715; x=1757017515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=526DZvOdfFdWnRr7VLIYoJ9rOuKdtRXZH6VtJYFQMAI=;
        b=MlEXdHh7J9SvwXHlNfmwPYQQvHHufsrrJyWgBL/dUwJmdgZoIbAm+Vl//p7lI/rCtu
         v/ReeH1YGUU0gMXFzNqsPmyiSucbDFnsOMukpc7ZZRdcRuE3lq+3BouDgFfp3aKD9abX
         Yj/Mlk/DW/1Ldy6ICIerBGc/852ewyvBFhkG/XK7TOFPIxuMo0HCt6o7K4/5MNfywQ2R
         MT71GesfUF3KxW60VVglgvIYW5adKO+cEK1cvx6V1jaTqYp3nFr4zUjGQoMbfBnx47vW
         /kMo1eVUI9WMrrTwqlcvhMFhJeiIAB1VVUS6qmb7dHDq2SBW9kWOUS9KvY7xA7Ksme/j
         Gidg==
X-Forwarded-Encrypted: i=1; AJvYcCVjUkNMi55DmyBeOWKO6yg7s4WUXGNkP7IYnFJvXPOIYedvs+d+N6ZDcX8EAxpNXEhgEtNCOxb0zDCb/kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOQ5f7XUt4NmXoiGI2Aq1f+8CigzKCECXCzKG4T/K3DEGn8k0
	tBd0Un947JtLY155x9wf0VqeQP9dAoyB13LRO0vSX57VvYE0syjJQ+YQt2L90/j4WA==
X-Gm-Gg: ASbGncsp9856mpggIfzkkn8u56GdF0T68FO9d7RsR921WxwfR38d6OKFKaf6NQFrmk0
	KxZ6atRgdiOztXDOS/Sl9AY/FLrdCk4CwYt1k+uauPvGXHpwtXVUfPHkqaOz9JDg6dwrRRixoWh
	VMo/7+Q7yQVaQBhS5iyWyC5YWjW9kbcQ84nDytYTkffwQFqXexC8BNWpNlx10PNNA8JR1pV1GJX
	1kk0HWuPt6q2lDl2uv1FFcuSYtlVqGFfeggAcSeJBgdECxne5Mqibkq8hOarfwu/ixdlWYRNNHs
	8mnx8dDI5C/m7F6lxA6mZuv1wzAi0iobbrHqQwNFqgNrU7a8qG7qZACwYEU1uRgtMWxiQ/qHvAO
	6PBEptCoWmSnl7jqBMewfem0mMFkWM7qQLm5OpgoL9MXvVZvb3pL0TkU2URyD1wsUfGS7718=
X-Google-Smtp-Source: AGHT+IGZpPB1acpeu6npCjJnCfSo43c/nVfDcPN4PgeohagoMI2YXoVU4nxMTi/b5qaB6M6hyplRlg==
X-Received: by 2002:a17:903:1b65:b0:246:b1fd:2968 with SMTP id d9443c01a7336-246b1fd2ab8mr192079555ad.9.1756412715244;
        Thu, 28 Aug 2025 13:25:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905bb28d4sm3845375ad.92.2025.08.28.13.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:25:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:25:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 2/4] PCI: host-common: Add link down handling for Root
 Ports
Message-ID: <aLC7KIoi-LoH2en4@google.com>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <20250715-pci-port-reset-v6-2-6f9cce94e7bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-pci-port-reset-v6-2-6f9cce94e7bb@oss.qualcomm.com>

Hi,

I've been testing this out with various endpoints (both upstream and
not...), and I have a question that intersects with this area:

On Tue, Jul 15, 2025 at 07:51:05PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> The PCI link, when down, needs to be recovered to bring it back. But on
> some platforms, that cannot be done in a generic way as link recovery
> procedure is platform specific. So add a new API
> pci_host_handle_link_down() that could be called by the host bridge drivers
> for a specific Root Port when the link goes down.
> 
> The API accepts the 'pci_dev' corresponding to the Root Port which observed
> the link down event. If CONFIG_PCIEAER is enabled, the API calls
> pcie_do_recovery() function with 'pci_channel_io_frozen' as the state. This
> will result in the execution of the AER Fatal error handling code. Since
> the link down recovery is pretty much the same as AER Fatal error handling,
> pcie_do_recovery() helper is reused here. First, the AER error_detected()
> callback will be triggered for the bridge and then for the downstream
> devices.

I've been trying to understand what exactly the .error_detected()
involvement should be here (and what it actually does, despite the
docs), and especially around its return codes.

Specifically, I'm trying to see what's supposed to happen with
PCI_ERS_RESULT_CAN_RECOVER. I see that for pci_channel_io_frozen, almost
all endpoint drivers return PCI_ERS_RESULT_NEED_RESET, but if drivers
actually return PCI_ERS_RESULT_CAN_RECOVER, it's unclear what should
happen.

Today, we don't actually respect it; pcie_do_recovery() just calls
reset_subordinates() (pci_host_reset_root_port()) unconditionally. The
only thing that return code affects is whether we call
report_mmio_enabled() vs report_slot_reset() afterward. This seems odd.

It also doesn't totally match the docs:

https://docs.kernel.org/PCI/pcieaer-howto.html#non-correctable-non-fatal-and-fatal-errors
https://docs.kernel.org/PCI/pci-error-recovery.html

e.g., "PCI_ERS_RESULT_CAN_RECOVER
Driver returns this if it thinks it might be able to recover the HW by
just banging IOs or if it wants to be given a chance to extract some
diagnostic information (see mmio_enable, below)."

I've seen drivers that think they want to handle stuff on their own --
for example, if they have a handle to an external PMIC, they may try to
reset things that way -- and so they return PCI_ERS_RESULT_CAN_RECOVER
even for io_frozen. I'm not convinced that's a great idea, but I'm also
not sure what to say about the docs.

On the flip side: it's not clear
PCI_ERS_RESULT_NEED_RESET+pci_channel_io_normal works as documented
either. An endpoint might think it's requesting a slot reset, but
pcie_do_recovery() will ignore that and skip reset_subordinates()
(pci_host_reset_root_port()).

All in all, the docs sound like endpoints _should_ have control over
whether we exercise a full port/slot reset for all types of errors. But
in practice, we do not actually give it that control. i.e., your commit
message is correct, and the docs are not.

I have half a mind to suggest the appended change, so the behavior
matches (some of) the docs a little better [1].

Brian

> Finally, pci_host_reset_root_port() will be called for the Root
> Port, which will reset the Root Port using 'reset_root_port' callback to
> recover the link. Once that's done, resume message will be broadcasted to
> the bridge and the downstream devices, indicating successful link recovery.
> 
> But if CONFIG_PCIEAER is not enabled in the kernel, only
> pci_host_reset_root_port() API will be called, which will in turn call
> pci_bus_error_reset() to just reset the Root Port as there is no way we
> could inform the drivers about link recovery.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[1]

--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -219,13 +219,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(bridge, "subordinate device reset failed\n");
-			goto failed;
-		}
 	} else {
 		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
+	pci_dbg(bridge, "error_detected result: %d\n", status);
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
@@ -234,6 +231,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
+			pci_warn(bridge, "subordinate device reset failed\n");
+			goto failed;
+		}
+
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bridge(bridge, report_slot_reset, &status);

