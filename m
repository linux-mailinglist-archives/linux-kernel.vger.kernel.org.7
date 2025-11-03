Return-Path: <linux-kernel+bounces-882320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35940C2A2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0684E188C826
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864D292B54;
	Mon,  3 Nov 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQQADloH"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5121578D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151253; cv=none; b=YXxVZKPtY4toiaMFX+6SW5SG/VPCs5FliPP2/Em2rmrabljD7otEPmguW41PCSMAz2DqSixZ1zHEto+CnFGufLHEmbcJ93wVxftFoLl5u53mR6aYTwCHtwtljIZE/xVnBm3Xzi0FuXEzaKF7/bNOsKGA1P9G643Oo6sF2hG+VBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151253; c=relaxed/simple;
	bh=9CT03J84ZWljzRjqGZlThYttEkMrtc79ah/qp0eHENA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lumNrQTAZGNAS2rpInvdPCjRGxr0O6x3TpkrFx6cmy03U1NrBhVlJu36DlWrW3f0nVK1L6GHWKyHa/6nNW+iwYxsd7PKYaHlzOnN9CeYz555ARZM4ZKIsak7rCDzG1jeLseqGZfaC08wMDcq7A3NvsbDIaoqxghnmTeSk8+CHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQQADloH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b593def09e3so2892828a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151252; x=1762756052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGQSi9N7yhCq+36qhzFLEOuP4uo/epjBJB4vjqFx0/0=;
        b=BQQADloH0VgR+Sp6h6d0IoHkZRYJnHtu8dM2LIn4h3AbGemeUEs+WK4B9+Q6dyxbst
         AsiIeIF+KkxrfWD7qCUXxQQjn67ojLrmL5rY9sZkLWggIfXnjV6iYZVU9G4IsW+FADXS
         Mo0tVXYW7uv+VW26GSc9o286dy55NS0E1WNk3SVcPYUn2VjoQrm3ygf7MYjlkXeHEp1D
         DxLJMWLPX/JrV4og6/YQ7nla0slDzp5qxmViXskAyjshLvEJoWekQwLRBSy0as+7l3il
         BK2iT8mPVKgpJ0N3j3yBAVsJcsNhuf6pu6fpJKX4cWPjRHSpEoNw/tjta8hrcD8Ec44N
         X7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151252; x=1762756052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGQSi9N7yhCq+36qhzFLEOuP4uo/epjBJB4vjqFx0/0=;
        b=HwGmAyr4P0UTDjmYXOIC6NuMk0/o0P9Ceno0OTAwjlTWeoQ3FZOJPddsCJHwTVNNZk
         SwdikwzVlUHFSRFMsnzlDIF98uXIKl3rrIcKM71ZW2r8jsJrRHKMjjPr/uEgwtvnXvnF
         6PsQxO9Azcx1cHTyFUeGv7BoNmGbcfNUvZCsmQG5R7ku8n8rBdzYCWsFUf3pphg4ZsCK
         FlKF3dk8I6bWy2W1yW+fou0KIILOfJHnbCGSVODJnNvAN0dAc08vhtYT8rzf+fZpVctF
         B49AzxuufCsQVbXbGhZRwPiitlZf9TdwEw1xMsFItr7AtUbjRUP4xpFI1vkfW8ubRAqL
         1/zg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1IPbIh7zrgoRrKtyAEaGqFCHsepEW9M2lg1/VaLKATiIOUDUU6PTdYJkmXIuSvJf+zmAtug6HM5uWKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIN9NwpR2xEm69vghd1Py0YdAsCHfUEsfvKsYyd8WfDvt5n9M
	Nedje5p8dVA9mK8EvTAO8SRRkDxTq7s+fkvdme7WyV8GopMxrfkun2wy
X-Gm-Gg: ASbGnctHEEiD7Sv0mS9p/DlE3Rs2DKsvyLyn8bqx9WmlGIxd6g9/H5Fa1ILXir1Wy7C
	1iqTgX7JP8Y2XUtsgkTqPtYDJ7I6q19wC0FrS0Q3Txpnp13OHSkq+scup3BHj5txsnW3qLMAbyA
	8HVmux/TrhHzzZ4Cuj9ENABi5khKkly+9qu0QcAebkiZCSeaJDw1U/1eDlh13yjUHHrN4NlUcma
	OFcjGJtwMslKZX+SDIPYbW8ar1LwLeZTFXiwk6GUFIuED91iyYBwwGdo+BpE4vFW6GLiAt7SZPb
	9uV6sViwdlBJWceUqWpzALmdRTyAs72tFB30q/0fHotI5XbNFUry8Fm+7FL4RiMbT+NS5ZlFrh2
	BGaWaRGThWTaZZNTEnNK/PvcmoeTG0OC/jj+6xvf+Qs2DgGncjSDYyfQO6GQ+odJ4W9I2m19Dwq
	Y4QSf70ZOM
X-Google-Smtp-Source: AGHT+IHygtYx3odpw3ozCs9WNVhh+vHH36qWHi9VL4Po+sTq1elwFX207ryIat6ht5qVwQ7NnSvjZw==
X-Received: by 2002:a17:902:f709:b0:290:29ba:340f with SMTP id d9443c01a7336-2951a47798amr138513945ad.42.1762151251610;
        Sun, 02 Nov 2025 22:27:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29564fb5214sm63355205ad.11.2025.11.02.22.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:27:31 -0800 (PST)
Date: Mon, 3 Nov 2025 03:27:25 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
References: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762150971.git.geraldogabriel@gmail.com>

With this change PCIe will complete link-training with a known quirky
device - Samsung OEM PM981a SSD. This is completely against the PCIe
spec and yet it works as long as the power regulator for 3v3 PCIe
power is not defined as always-on or boot-on.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..6add0faf6dc9 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
-- 
2.49.0


