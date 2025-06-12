Return-Path: <linux-kernel+bounces-683458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEEAD6DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FC164C29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B922F16C;
	Thu, 12 Jun 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAZH+8yC"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EA22DF84
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724188; cv=none; b=iNmvTaQ6WdzfOaBYJJf5UCVs+pJqbIAiYVz9Abk1P082dds+SBAzuCiXBM+Alep6qrgmAu1+x64w+RlWJ8nKkzf8aJFLbKyEfkqyZ3OQxlnaEQ6BbMIIEvW5Es6REJJlrcYcSRwdlxPiCzEZrjNjWTbLpe0G/0Gs4avmgnh9+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724188; c=relaxed/simple;
	bh=LBiZjj1c04h2wKgu6SjWXxVcIMRnF5MvTTsJHW2Ksb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59pRKYtUQUhElM1orzboSBhKyjjcyiLAnVCNrdPkQQ2ZjM5bsTcBDAbFggKO01lqJIFrCxJzX1Al5+xhMIi+WgCJ8BLlEqCqtyYDEhIMxUb/cMyhPyiT0+wqG650s9ypnEYPxmwRHVHEzMLPRjiGYrHVdCV61nBmGYUTFV17XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAZH+8yC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso562756a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749724186; x=1750328986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=ZAZH+8yCPSa6m8A5OO5z0I+JsTAU0Y16O2nTUn0F+56+r4H3gZVnoAs43LeHeEbCeb
         UU1ENxbcN8vJW7HEkqhS377VhZC/Km7dSCLKUTzgmqpQ0KG/5J7pLYpGferDpDhSFNaZ
         cnDcxUrkg7pU8gF4FPVKPAtJpx0tWNY9mmXLaq1j+5gE6IHIBR84s5wB5IYhwBshbdr5
         i0KHpk8mZS2oginkAgTPBGveVcfmeNxyAg01OzNEOfwIAwv6arYqDiFpyCW+FvCXBkEw
         hFZRX+FKPwJpl1Ocp+Se7/g49JGvOL4Tf09aWrDf6rVJXIVu/pY0xVFJUa4CfQFZhq6/
         sGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724186; x=1750328986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=hngnhbTCN/iVxPgk3I/NL1r+9hszfMjIN+Zjvh5ZhSTjzJaQu9cGMrESD57tJoaqi7
         eeDYrtofJKx+LndvldzrisXfnYjgtDuXjRnyzBE0b9ycKYonFTgK7F1He+zFGqSG8oQA
         NmzOK+/Xt5jBkHiwzQyx4bIGhxLbZTu5O9YPLTjV5vYO2hRFIYGCEJvZQ8lWH0g/rnGB
         3lyJsEdM/WtYQUnugge+QvcghYSMFps4n/DesAC8Llc6729EDhHrTVX960AqyqJmJvLr
         +TRreuvEOQNpHE0Fo07qBBFQjhp8TvGUzhSEHYUozoetBscm4m2zyHN2dvD9lkRj0tMv
         jM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpgJxTF57/D4k92FPAg6DfD5B4zFgegY+zycQZKegMYKc3gBDsBoIAR0scwpQ6jTm0zBMQ1rteM+GCAMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSy8NwTFfxRPurGINJl/1Z1/TK26+o7tk9V6wrY0LvNMUMBRF
	vsoC6EZHm8DcBHBdUzA5ofu9lsVUrNWuFCh9fOXr5pYSME1XQ6OeTvty2PkChyEzJrE=
X-Gm-Gg: ASbGncsDMK5sxh81tYkNx6o9ywRKYEBxSJ9nlMdbGQZgmiR+Y09f0LaL1qZhxJkwW8V
	8Pfw8wwwZ720qrPC+ZJ51oDoEFOXYhdoPz+chgk8EBN9s9MWs4pMU5uYtPBuxZCpWEfZbysB3vx
	NKUht6SwqArXDyNcEid9aVLJJ3oPpeGIGSvnZl4VaOMPLqamMe4usHclhLoYmkSvRto8OAneawK
	JgN49UY1TeyRNYehj23J1wfDRoNdpqL0XiXHOaOqeeoYLLMcrTOXUpFL1YYd8YAz/7gVMPkHpD2
	VZPpeDxtDW9OSTZ1snl57zwfBLgX9FJCTsJlrYDF1Glb7NBgDnkdTksA6VFuifvg/0sUq3n2SA=
	=
X-Google-Smtp-Source: AGHT+IGj6zH2i6FSYnQuoWZbvieZJ82el41fbjoepfDccYSCZ6jY6ZrPdhwat+GRxvtW+AAp+Hs2QQ==
X-Received: by 2002:a17:90b:4986:b0:312:e618:bd53 with SMTP id 98e67ed59e1d1-313af1e44a0mr8462248a91.26.1749724185738;
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b4besm10717505ad.27.2025.06.12.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:59:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250612102942.iqdqmu3dolmgtmio@vireshk-i7>
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
 <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
 <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>

On 12-06-25, 12:22, Miguel Ojeda wrote:
> Do you need it there? It is trivial, so it probably does not matter,
> but mistakes are still possible (like it happened in v1). Since it
> touches files from a few maintainers, it would be best to put it
> across the "global" Rust tree (ideally with their Acked-by), and Cc
> everyone (e.g. Tejun added now).
> 
> I also have a fixes PR to send, but I was not planning to take this as
> a fix since it is not marked as such.
> 
> But I don't want to delay you. If you need the changes, then I would
> suggest just applying the parts that modify your files, and we clean
> up the rest later.

I don't need this for my request. You can pick it at a later time.

Thanks.

-- 
viresh

