Return-Path: <linux-kernel+bounces-795724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C18B3F717
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8470F205D00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9872E7BCB;
	Tue,  2 Sep 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKWMr3Ns"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE12E7BA5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799613; cv=none; b=PGh1WYcX7bSkJT1onqQ8vkaqDUJ/ZszQoosE23u+5mhfS58NC2aQtpxKGinqNqvnrwePwR1A2Vayq6qMrmoIdfwjjzt1gK6QtgiYEoSJ4Hdj/rn8aKhYpityM+S9wb/OLCrPLZxl8PEhehsqtP9CcgpKezq6GjP28L5hHryD25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799613; c=relaxed/simple;
	bh=L8ue9J2vi2pjgMfgSyWzh7k6KFpTN86oCkpQ3AgDGUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTFyepzyRgSWPFz/lmF4qluercjuWKsNZvCAaP6By7+ltt8PTFNtuUt45wXNqdwav3ulzunmXNcVC+4h/2rY8Oh502sAvkbEXoQEFr7Ixofj9IL5j/XEmPVAoc+Er9gmDaLT+UDI148EZ7J22BLBdJTrE00Bf/I0GQUQ9EAR7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKWMr3Ns; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so41057015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756799611; x=1757404411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX/i8pzWZiHBkXFSxW4oFkcmw7w7tGzt3veZuRyONCs=;
        b=zKWMr3NsG5/3GCK4a6V+eO2BtvQxlaXT5jCUGBvD5595zQFfb+SDuXlBJkjiY79uAZ
         v53TI8QI8PEDgCAtP4Sqj3GvkoeAops2H2OGr7hD9uMmpC5TMWFjCqmZqOi5zoWpwkcu
         a8foElgB9dQ6SCtv31Jpt70UPWVJM53ALHWIDFic4JVLnLVcSFyv125DoXdsWRVUto3C
         q1Ux+7GyZ1xxs7g2t+UZIgk/XWBpIk/QbpIAC2BtEiPZAnuag5FOM9njJiaIvfeRXjof
         fTOMgrtoPuPUpadTGjNj2ypO3pd2qghndtCsgY5p8iMGXmSql58n2zB4EBQ5wACq2HcI
         oSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799611; x=1757404411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX/i8pzWZiHBkXFSxW4oFkcmw7w7tGzt3veZuRyONCs=;
        b=nWfwW1Em+LPYjxl8n2WFGal1f6UHUlIuSPfaWehsmY2Q3i51WqBZvO1wexPZSRXOZb
         mt2rDrfxDECiKAklyCTnmMppQL7Dtp6vSEBIeIx4EwzWMRH2qCVXm1p4TVkNPiYRwPW/
         KiCGio/dH7bzSGlnxQ6Shjna0q/ahu29HnHkBmc+7njT3H4QO6b9pgKJ0AalxHl0SmO2
         aW4cOhPPTePWWaLWFpDSzxctJLoL1quUWNbQh/igd5D0C6LjGoJHJgSfH8aEHSSue/Fr
         cfbZr0LRWGjnzJx2s0QrJZGb9q1RoRZk7Ypurg2DWAj1/6K1rQbFJHQ1iixdSppbiqwe
         Rl9g==
X-Forwarded-Encrypted: i=1; AJvYcCXcDYv/U3TFs8JLippKXO93Yk57jMgu6Ols1M3uOfm9AKwq7s5KVrqQvj5vEVX7W+qDLCqciFX/+Fs4KnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywha0QAuOZPnE7HOtj54nF7ksE5A0M6+fvU2s35CfRPnommHu+r
	CCAxlu4LY94b12ZcfCcfyYheDaI6SAoRbLyAl3rGdsek9IUfEw/oymZcVilQ4oCHXRtgB+Zz56s
	5Y1Wj61H2/zcRLiJnvQ==
X-Google-Smtp-Source: AGHT+IHRufGwFNMIvt/T3xJQqvQe4WFWXNq8a8WfNU6rCVwIEubSuGF/2DraRjnBtfk32fnbTi4quo01Nalys2o=
X-Received: from wmsp6.prod.google.com ([2002:a05:600c:1d86:b0:45b:9a77:6f95])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3145:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45b85570838mr83318775e9.21.1756799610677;
 Tue, 02 Sep 2025 00:53:30 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:53:29 +0000
In-Reply-To: <20250829-regulator-remove-dynamic-v1-1-deb59205e8e9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com>
 <20250829-regulator-remove-dynamic-v1-1-deb59205e8e9@collabora.com>
Message-ID: <aLaieVp1U9JTTjP4@google.com>
Subject: Re: [PATCH 1/2] rust: regulator: remove Regulator<Dynamic>
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 29, 2025 at 06:11:31PM -0300, Daniel Almeida wrote:
> After some experimenting and further discussion, it is starting to look
> like Regulator<Dynamic> might be a footgun. It turns out that one can
> get the same behavior by correctly using just Regulator<Enabled> and
> Regulator<Disabled>, so there is no need to directly expose the manual
> refcounting ability of Regulator<Dynamic> to clients.
> 
> Remove it while we do not have any other users.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

