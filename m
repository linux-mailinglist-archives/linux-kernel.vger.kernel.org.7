Return-Path: <linux-kernel+bounces-789593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10949B397CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAF47A9414
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A52459E1;
	Thu, 28 Aug 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R/MFZaLv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9030CD89
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371834; cv=none; b=JGX9+xzoaFGdqCh25bXHj9aGUekHuB2QXXSy5j8fGLtkZSgyv1dRPzAYF/SuXO4ESS3gp1V7eOkQA/HLPOXrjhVH77gejQ+gaQpDsi7qDUgETUQgoVPgBK5kKRHdCsUXEW4LPkouK+7mVhJBC7332UhBMMrkTN6n2j1MZYgAJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371834; c=relaxed/simple;
	bh=P1Km7viXNhdxwdjmJkd8eGWJ5f9QqWJPyNfjEulm+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uINndGcodDeuxwjSQ8UJJmdYZvNoUtyR3Z0+enj56tAuh4FlhSgR6gfBiKFXuGTWPvB111tdJ+0YYofONYs/zl6NjSW4NLkc4EgjZnXeFHHXWEmhyoaLxKvJ3OTr7a51z6i6dxa0CWD2yiYKEZ1dAYvgJQP22JhCfvgwwkO6bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=R/MFZaLv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so1722645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1756371830; x=1756976630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/tMGPUR6oWh2VD+AseVEvZ/r11JVAy4s+xORZuZrac=;
        b=R/MFZaLvBWrTDIPMhHquzrtw1ZWJRiEQj4DzXH3tVklmvs/YUYsMTX8XwU2/IOJymG
         YmI305UI8aXxmjF5Gf1aCbvavcyGv2SNxZZJgRlFBv06k98j9ZDHkJUZ3XRyTs4uvr/K
         wn8aCDet6WLVlHu/b2tcDrfxYEX6tY0sN24rXH5KXEMQQyeMomXSu73grJm8FJhpBXIH
         r4qrLFujyVxvPXjkT5c7ogt3i6W3kadKn+7yuMZ/6kmr8ptmvOx/VYlJo2p2G7Eea1p2
         WqK1WbEe/uzn95WZlueXT+ZHAU6Eq0PQVjegDluVBB6a2BZwKYZqmxzr203Mm7RJdQzk
         KuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371830; x=1756976630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/tMGPUR6oWh2VD+AseVEvZ/r11JVAy4s+xORZuZrac=;
        b=WRmteF8PriIUaiGR1tEXlxLWMeM2Ce5wNf+rSMBFYzgx3IfRRBPspuBMgU+VKalcNn
         i0//96O+3dnCkrj7UlXS3fTm3nD7h7LjiqGVYJ8B/vdbhqFNuXv9FOhaG8eaA9e43BtE
         F0CzS3W/2zIelRfVnW29k8qQbW1cWX6W7p7xptlBqwKLAYtPo0SmG5LR36aILhqtysN5
         9zl9drkRD9kjjH/Fza57toMm3srZXjTn1R8XwRBz8WfnsW6dK+4zEPEX7/JuAfXkGGSd
         driM+ad921ZST4+8nvYP7mCT+9OwkttCNUS9FcnW4zzQl0rtuvqOG92cdSvDs/n9U3eM
         d4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAYyn4y5s6agRXVlnSiAHPLHJU7QYsciSCl6xOr8c1BOYAS2Na1PbnTfpgMkwBheSx5WRYCEV3zzxg3Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFglAd2o9NB0Rw1O7lf0k4BTEOrbbvN3lQ+a5+lunp1Mw0ssS
	pz9Dtv6WGTOgnEebTyu1pQ5ktb3n5/c+xIu6ZqN6t9B+YaYuYXWU5ZxdjV1/3PMFmts=
X-Gm-Gg: ASbGnctDEfxrbfn1TMxJrM06sbJcscQet4Rk5wzpFDeDxgOaqVncbF5+a4XBjILCGAM
	2Pakp5UBm/CGFM+YLjM2ukv5kMNKWvaEzbUhgcSoCYx20h1oxGyO1ZibLxEginUdt64xBFjKmjQ
	bdlDwtggYRL2nW9lx0O7Hl1HKtv0rzj/qvpvnSI20FSCwDbyAUoETB6iEXoVJfrrWXa2THAjsWi
	5Bq2bKtdTTq9dWbekWlR2/RqyGgYUVB+dakoltCHamyD6tw0prbTKFxtEdQdPRSeIkxPYHkB+8v
	z9XaHoNdwHgPe1FasBzL68BNDQ8dkE2HxeUmTAKGWo7FmhtBQCer6jCpDrtRDlY/VupEjPzjVoB
	8Zi2RfkGv94QUwQGY+CFXM2iRQ/r3cW0WAXU=
X-Google-Smtp-Source: AGHT+IEQkb3N/KBo8fFYG98LYdWj+YzrY4TyITmKn1kxcqsHzLx+fbBxRmb0Q2QgmqZTikTM5/a1lw==
X-Received: by 2002:a05:600c:19ca:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45b6870e3dfmr83816435e9.17.1756371830191;
        Thu, 28 Aug 2025 02:03:50 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm25342324f8f.12.2025.08.28.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:03:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:03:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shay Drory <shayd@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ozsh@nvidia.com, mbloch@nvidia.com, tariqt@nvidia.com, 
	saeedm@nvidia.com
Subject: Re: [RFC net-next] net: devlink: add port function =?utf-8?Q?attr?=
 =?utf-8?Q?_for_vport_=E2=86=94?= eswitch metadata forwarding
Message-ID: <ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
References: <20250828065229.528417-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828065229.528417-1-shayd@nvidia.com>

:q
Thu, Aug 28, 2025 at 08:52:29AM +0200, shayd@nvidia.com wrote:
>In some product architectures, the eswitch manager and the exception
>handler run as separate user space processes. The eswitch manager uses
>the physical uplink device, while the slow path handler uses a virtual
>device.
>
>In this architectures, the eswitch manager application program the HW to
>send the exception packets to specific vport, and on top this vport
>virtual device, the exception application is running and handling these
>packets.
>
>Currently, when packets are forwarded between the eswitch and a vport,
>no per-packet metadata is preserved. As a result, the slow path handler
>cannot implement features that require visibility into the packet's
>hardware context.

A vendor-specific slow path. Basically you provide a possibility for
user to pass a binary blob to hw along with every TX'ed packet and
vice versa. That looks quite odd tbh. I mean, isn't this horribly
breaking the socket abstraction? Also, isn't this horribly breaking the
forwarding offloading model when HW should just mimic the behaviour of
the kernel?



>
>This RFC introduces two optional devlink port-function attributes. When
>these two capabilities are enable for a function of the port, the device
>is making the necessary preparations for the function to exchange
>metadata with the eswitch.
>
>rx_metadata
>When enabled, packets received by the vport from the eswitch will be
>prepended with a device-specific metadata header. This allows the slow
>path application to receive the full context of the packet as seen by
>the hardware.
>
>tx_metadata
>When enabled, the vport can send a packet prepended with a metadata
>header. The eswitch hardware consumes this metadata to steer the packet.
>
>Together they allow the said app to process slow-path events in
>user-space at line rate while still leaving the common fast-path in
>hardware.
>
>User-space interface
>Enable / disable is done with existing devlink port-function syntax:
>
>$ devlink port function set pci/0000:06:00.0/3 rx_metadata enable
>$ devlink port function set pci/0000:06:00.0/3 tx_metadata enable
>
>Querying the state shows the new knobs:
>
>$ devlink port function show pci/0000:06:00.0/3
>  pci/0000:06:00.0/3:
>   roce enabled rx_metadata enabled tx_metadata enabled
>
>Disabling is symmetrical:
>
>$ devlink port function set pci/0000:06:00.0/3 rx_metadata disable
>$ devlink port function set pci/0000:06:00.0/3 tx_metadata disable
>
>Signed-off-by: Shay Drory <shayd@nvidia.com>
>
>
>-- 
>2.38.1
>

