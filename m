Return-Path: <linux-kernel+bounces-840771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992BBB5495
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79DFE4E700A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18927A924;
	Thu,  2 Oct 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjnxI9Fs"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175F277003
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438350; cv=none; b=n7x15ElpximL4AkqiD6HiiE9bRAgDdqKJBoddFgu2CLMFZEILnVslT3JanqO70YsCUMrcfE+NMiSdTS6B+2Y6/UNemtm5xX99s9esDM3onc/0ojQ6MjBLm/bCuyLZtT2wj191+m+5S4eYuhXh0yHrJYKYXrinT7mzgXxa312shU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438350; c=relaxed/simple;
	bh=DvKZeJuc8q1pMCcveAAdBLsuoO3iYHiqN7Yxh8CK/bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMB4i9EDJK/leHkmDP/4X/j3k2JrilEm8HlO9mn4zeXTvM74xgNnyuJy5P8GUfazq6VFyh+DmGv1BnuXX9GzAbSytJ1b4q/Awb/4u0lKuzV1XQo4XXV06V6spHrabqFMnAeQeUc2iK6pDspMK5hGDU0PzvNETq2uliE2HNabkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjnxI9Fs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1373856a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438347; x=1760043147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt8+KJKLTvjnTsuEvXC7oAoHF1RulS1QZOqpF4RenyQ=;
        b=VjnxI9FsS0LtdoezIfJ650dPiD8s7Qdm80G57wvuC7AZs0vPjHFRa69WFn+P0AWUcT
         HT0Wfq44xLZD3jUpHHr3kREbXlx09js7vVtFUgil0tPOcxv0JFYT4tgXC2O4jjPMoLf+
         VeKO+Htwevi6g/ZNPNrEwfh/YiLOKzGYaXSKqJRx5Hhd1lcbDbyWzElr6JiC+biTOIrw
         6bVn/8terpx3pJFrCNKPNdIJgV1edcmgbnFFrgJyKo+vYUaXEa6c7dk886HXuNX3ev6t
         +lw9dxTFiC48EWxg4QgpIOijgVNFzfxTmb7AZbjiGRX4ttXiNod1PI/M0PJWCDLpR3W1
         fxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438347; x=1760043147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt8+KJKLTvjnTsuEvXC7oAoHF1RulS1QZOqpF4RenyQ=;
        b=h9hRfrA1ZRZhP+0mrxdQuRrCL8xWs1QJmJU6+pKW1CJrTSec2/p8EuLIGq52dqqY71
         WOc0MWI7TCNkgZGGBxBxDv7t8iq56mdCBxqgmxjcH1UhJrN1E7/37se7vTRuqHOV3qqs
         NODnc/N6vhesBRt3y2DvkL6QWaMf4TtUInWZFe0F5gENJbuq4vxLhaMy/qgU4QBQl5ZR
         4ZDr4nlNlrwFTNjmc2IjXmAArpy7I6soyROhcQdzvbMYzFKZ3ZMbEC647XnY0lrEZ5R8
         sEXX6K4BlmeAzwKJae9dx+7xHSxgstMgt9CEo0r5/h5xl/kjQji8gXDZX4bkhPxeCkxP
         lvjg==
X-Forwarded-Encrypted: i=1; AJvYcCV6L8zM7ZQRZoosXHXgTNXSLqJCBIhNDiX/+zcTT8GK/c7To+hTCBGQ9JVk+TMYINgkEOD9XdT2g9eIPwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Y0Hnb2+pIyWZDPCxqLJRmW8RWDyvgslBipjRiRaSggcrgsB5
	cCJLAYQxcfuGYVh2u2hn6uWE/MECTFdf2HDHwTA3Ok4/i1G97+TXZMd3
X-Gm-Gg: ASbGnctzmuZUYeuT2mcCHzR1CWPDx8xTGDIFWKQBlgYYICsnddCXtVqqG3EpkcLwXnL
	leOW315+7MkwMdbbDdlR9AJaNzPnTaMUQQFQyFOrzGvALKzN9ZKmMvsxS+D+L4SkylT5dpdZnvX
	lvHJtx4yjYhKWNaofj4Uxoym8qvhtHAJE+96EOckBFb4APPztwYuCJcYKXIYlFuhO42Q15+xqtN
	jmu2Dqt8i1TBhAcviPjoqQOqGTVyXBUIq/i5Iymcb7780l+21ABjUADm8vnHo4ZJIdtMAHpHX0e
	r9eOH6Wp9ZYiwkwWXj9WOLGBN1jTyKr9HKKcOH+gLY01wqWblNwyEokfPDxz7RGrk3ipB5wgVXc
	nZzjEi7r3IqdjJiPkU9X8p1TyL9NuEOUjfi7meOscedy44HvCQnZ+F6wj/9A7HUsxD5dF2g==
X-Google-Smtp-Source: AGHT+IGUkkG0M/4u6akYKC5LQ5MwjiuQ21TfsswJrB9jKVK8JMKVo01HtMK12v0tDjHeG8d4+1MNuQ==
X-Received: by 2002:a17:90b:4d0e:b0:334:e020:2f16 with SMTP id 98e67ed59e1d1-339c2720714mr717648a91.11.1759438347329;
        Thu, 02 Oct 2025 13:52:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701bf31sm5792124a91.19.2025.10.02.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:52:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 13:52:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Message-ID: <7c751da9-e480-4c20-85e8-5ceaaefa1027@roeck-us.net>
References: <20250928092655.1394429-1-wenswang@yeah.net>
 <20250928092845.1394718-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928092845.1394718-1-wenswang@yeah.net>

On Sun, Sep 28, 2025 at 05:28:44PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS mp2925 and mp2929 controller.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied to hwmon-next.

Thanks,
Guenter

