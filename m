Return-Path: <linux-kernel+bounces-889684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E684C3E3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4EB4E94B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797102D7394;
	Fri,  7 Nov 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqUXaJWB"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8312D641D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482156; cv=none; b=fpi87JaYySU4ZEO0YtTvK2tav5bFiidWJTc2t9UHfW2c7GxwbkCe1BqkUBTJhw3OfVhNX/8LeZMi08ShFAQk8SyDDHwtJkClq8dAcxhPnhbJGiU8dep4cuqf6m7wwDiWM+BC4F3ZG31F/XC6t2Pb3pHwnAUZyFqJVSoIT5e27l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482156; c=relaxed/simple;
	bh=2wJsYMHByxXf8C901yNivTAphL8IDvSKSXz3egAjoMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzLbCvyYcwfLrrg9YdsC4EldNH1ZNh71BWGLwvQuVpjIvTOiDo6nlGsJ68d8BLqGuVueazdppzIjjNVRXRIUG7pxKRpbDsZEqXycp+zXydV7CMwrKNeaeHIhHFQvSm2gglTRRsnsLjiLCKOukQediUaVLkfE6pvyS6H+AAv0TvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqUXaJWB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786d1658793so2890627b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762482154; x=1763086954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9ARDwGb0uPrxOLhySJFLBJZQJy4UrXx7An6ywngF4w=;
        b=DqUXaJWB5PXNmMbZbMmV8yU2xnR+VMGbcSefumrZ2KC0fP4PSExfVQyBH7/dN4XMy8
         bP3JRnp97MEXxuTF9MK1pNo85R2zbXJKuQF3Ki+uCo7FZT8Zk6vXEl2qdn5FC2EP7qFP
         yk/d3OxPE5xIUNnSZ8nX/msDGXjfhRxnAHUXjkZnlHaXtcXGvgjiPX1sv5F4yyvw+DSM
         GUraAmB8Uh7dYG/FU658NtFUownW1LBaX2F8wsByylqGJ/z66YItnMxksifX4KDNRvRE
         kmi8Ivq4cEGkJyq2a/PpZnX3jEgmIxPgGlS/CYYx8uufjNsIcY67wvCvwc/14V8GcOVC
         LHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482154; x=1763086954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9ARDwGb0uPrxOLhySJFLBJZQJy4UrXx7An6ywngF4w=;
        b=RUY01t5oM9Tde0etHPVFG6pgNFATX2KwHCeDGzOEq/ncUG1i0lt1dxP4pP3+grLAz8
         UAeuz8EgwoRnw8i4oyF9WJEUdKsuEDpaol1X54v+atAsZQZtNsBgYG/8b3/Fb6B/m8fv
         IuobW9qpRTtpNqY2O/HZB6fwqTFwvjG9vbtUgk2wKVAnWyzDCyB/Kzz7ZDxPRFlpXiOT
         K0PJA0JPUSxBurzDMIL2kd7FeKghefgEmP72ENUFyi7FO+kdReo5MQWaEDXb4/HMqEj2
         k7oTj9caK8fyitxfTGruSz2L2OdpLyj09YsmAhEbKzwTflu3VvDwJ2W2moVCTRdQUlhW
         isyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJcUAp7DnIHoHOYrOemaTlU9qMvxrKmVXSWuNVagWp2ZfgCL6/pP7cKnPst9k55gJ5tv89U152nOzn9lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNLIAaOpwhuJNRvrAZvQjJWakWqovoipiwVXqfWYEWNtIIiyr
	EaKzfEHUNblHqVd2jBr+0N/DYfxaa0bz8Ey3yDF5MudbCUUtDd8bQN9r
X-Gm-Gg: ASbGnct7JQR0vhaPTWUlM3coOBs9hncHteo7BRQsDAGchAW6IcsjCju7kSp4gWILUcn
	82AePt/TdJbK1a7UlktPLA91uPEEJ7d1Ly6OMVrDWyO78RtFzJlE01Kb1wroCxrG0Vtc/WG+dPQ
	Aj+JpjSfz8/FDV5cSpB2ik8VgMSwnz6WFeBZ43byr581qrdeHrgrCap5jNBasXY2yaHmiYY/uel
	OtMT6bW/A9gS+D72NlTKDidXr4fHQnfsowCIu9LU5r1+TLUBxB2OTsnkX6PlR0qErAtoRi0IG3t
	oJkJ09XulfcQ4UvratPLJuM5ZuCfuL3zadPY3X8yy8LYbtRbDHqOKK3dTOOBnR8WONTVasJNnED
	nnzeudrFgaAd6s2cBbRRMArc310K9pT9hjNhaB0BXK3KS8IWv8yh19anIhW+mgm7xYQa5rspT1m
	46TuFtRsyssp7vri1l6BUgxhByQEYOmUmgVACg
X-Google-Smtp-Source: AGHT+IExkQylr1jShV9Ea1kIXdpiUjvn8t/+xJOL3Cfgf/yFTKueS7J/oTfsuiw/7plu274iEpUp6A==
X-Received: by 2002:a05:690c:6f8a:b0:787:badd:4c with SMTP id 00721157ae682-787c534ae89mr26865527b3.27.1762482153981;
        Thu, 06 Nov 2025 18:22:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5c91334sm1361787d50.1.2025.11.06.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:22:33 -0800 (PST)
Date: Thu, 6 Nov 2025 18:22:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQ1X55NjyDU806Tc@devvm11784.nha0.facebook.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
 <aQumHEL6GgxsPQEM@mini-arch>
 <aQva8v22RVQEgPi_@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQva8v22RVQEgPi_@mini-arch>

On Wed, Nov 05, 2025 at 03:17:06PM -0800, Stanislav Fomichev wrote:
> On 11/05, Stanislav Fomichev wrote:
> 
> Thank you for the context!
> 
> I think that the current approach is ok, we can go with that, but I
> wonder whether we can simplify things a bit? What if we prohibit the
> co-existence of autorelease=on and autorelease=off sockets on the
> system? The first binding basically locks the kernel path into one way or
> the other (presumably by using static-branch) and prohibits new bindings
> that use a different mode. It will let us still keep the mode on the binding
> and will help us not think about the co-existance (we can also still keep
> things like one-dmabuf-per-socket restrictions in the new mode, etc).
> 

That approach is okay by me.

Best,
Bobby

> I think for you, Mina, this should still work? You have a knob to go back
> to the old mode if needed. At the same time, we keep the UAPI surface
> smaller and keep the path more simple. Ideally, we can also deprecate
> the old mode at some point (if you manage to successfully migrate of
> course). WDYT?

