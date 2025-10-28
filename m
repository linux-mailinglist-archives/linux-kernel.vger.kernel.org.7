Return-Path: <linux-kernel+bounces-874051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E54C1563B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D2F1B24D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F233F8AA;
	Tue, 28 Oct 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF56fZeM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA3376B8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664806; cv=none; b=lLIaddsXmdiIxoQoiygNT4ELaoYaveQL1lC+8iwNwF91DPpg9aV/Da0/vMlc3HA4B+5n4x21w4S95QaQ4WJy0s1Th4aXusPnnGzIxoG9ypwfmKKzfi+t+qEKg7DVF/mukmFCxir82x6vihMfMBfXz2iooOE3V8uhW1yZ5Tewtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664806; c=relaxed/simple;
	bh=s4Gx6QagiTUE1mIaeDbONB9+Ep16cr+q0GGk6X8s7jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA4tLqL3d+nn3qS+meiYW8tqEXiGPQFI98nHY7kfmm5GxhNVkJ4uh09jtJL0W3SpBjQ+cj/jSD+h1HocUrgAEVVjtSCrSf6qPTP+Vc2heAUEsSE3mwRkxl90k96xfaSopvGO7aDfltjEDdLOH0LBabcruUbb13oBY1s5s1zNfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TF56fZeM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dd559a83so20327375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761664801; x=1762269601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4xM4gK6/cv+oBkMKfsDBfGRWPzGwfaysxJmVNv0Gpw=;
        b=TF56fZeMJfUYiZDzHgEXEBErcxhwGL2kWDZCu8XtcpruE1LQroQdNkUzsrZ7RskTLt
         s7Le6jVDSg9s6r3sPmj9SZ9PGUk5bWnQObnBChD8dq8TDM8+ORj9Z59wWxSkMJ14Hbwp
         SNnSzwAnIey0gfb3JeMuIHg+ImD3UcnnxMmUj2OD3OJ6NWM3TO1Pbdx5WESyEVM8OBPv
         qDLWDw68wnNrkHFYqzUP1gw+uijuykVKFpxsRjU/j0rhCmCSIGh4RDmxRHwBAK8U33+o
         nq7qL42W/0m3KN0exH1mYJ4E6dYYYFDXCbwKMFGRhYHEQveNPPpTJx5xS7W2OFWSDfyO
         jYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664801; x=1762269601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4xM4gK6/cv+oBkMKfsDBfGRWPzGwfaysxJmVNv0Gpw=;
        b=RUNxbjt6htsu1UEv8/N0YNoKDhxw5dWXpSVMTnesD98+Wsfhb4Sk+W3FvlVZtsORQy
         gNEnCRLnPC324/T+mzCpwIpE+5BwDTrdbnQl+JY7wd9hd9QM7tv4gCmj0UKpWNTBHNMa
         lw5HzuZ0RdX9Kf3Y40UPp5mbTmOBjAItI1NRO74OUI9IjyOZfTYkgoW6MmGkf7WNaCOT
         zI3tz+zvt9D+O7Gk4NQz99BVhry5VuEr1eL+WPXNTvE+P+fyL2ty+KNe+P2wVrTmKSKL
         5Uw5JaBSG/NPQuth35DDIABPMGAMYeXimfYgLk9+QVAb2/thjmN3NDPbH3wk/oNVMBug
         12lw==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ7j6tWAjNku1P3UJ1K1pdDAF4GsvAlUTfP25ITNobGDFSRlhA3Ll4zbjOKoHW5rJtMAlO5TopZ8RQ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTY2ND0gOsQ/pD1oMhYblLXCXaQdeo8GtE/YVLiv9pWrFrhVF
	6MM7k7ko5ivKXcDRezcu49MwXaREmA7O9lbBBftDv4qpAvyR3e2fp1rMAsIIJzpWodW2ZW83gxm
	eaBse
X-Gm-Gg: ASbGncsS6UYfteXavdwh479aV8aswh3QaDb8xnHaz9wpP/BLq97SaocyoEUZLKp5cyx
	T5no3/mYgWymXPD+8arZWIcbqnQpoI+9zunZLo5A4zn1yy6JFTWwkqXCMEPm4Xmkq+uh5Tz4OZz
	M7g9XDdtPPlXUiYdzIemCKeyr3S8ZE1bWQGz7IDaH3YdTzfYKov85rXONswRxJD3LS6fKIDcSHM
	S49KST3tVjpX6WX5O2OMt9UwYXDTfkzDVhRL2Xv0CHBtwo+w0Dv2iApNQkdwB1BOD8+L9n0xSvh
	rBEkAN2EM7axNzhNKZwASVTvjJp9F8L3pe5JG+HHO7VkdBD/Avs1dMcsm48ApLVsArAuV/Rudcz
	1DjpxuW9svzAwWWrLZ5wrhuq60HrNM+TuFCKpzuU5FBc8mWG+a7TLqxjUFtyloU+ekhTKLSPO
X-Google-Smtp-Source: AGHT+IGKCeR2r/LqTWZfnp4F6FPA5DKpq/WscvEqy8cVGEsQO6uQyLdM2X62ZFpf/CF88WVJpNKzJA==
X-Received: by 2002:a05:600c:608e:b0:471:672:3486 with SMTP id 5b1f17b1804b1-47717dff927mr33130885e9.15.1761664801353;
        Tue, 28 Oct 2025 08:20:01 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718ffa42bsm21650985e9.4.2025.10.28.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:19:59 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:19:58 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
Message-ID: <a4f3yhhz5sntno6gnfbjnjjsbtyo2e4y3da2aywsg36gvxkaxg@vw2vryukrepl>
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>

On 25-10-28 16:39:19, Abel Vesa wrote:
> In case of UCSI version 2.0 and above, if the orientation is set from
> glink as well, it will trigger the consumers along the graph (PHYs,
> repeaters and so on) to reconfigure a second time. This might break
> the consumer drivers which aren't currently implemented to drop the
> second request of setting the same orientation.
> 
> So lets leave the orientation setting to the UCSI generic implementation
> for all platform that implement UCSI spec 2.0 and above.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Ignore this one please, as it is incomplete.

We need to also set the orientation_aware in pmic_glink_ucsi_update_connector()
if the ucsi version is at least 2.0.

Will do and respin.

