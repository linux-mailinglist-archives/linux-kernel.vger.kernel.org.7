Return-Path: <linux-kernel+bounces-864098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2ABF9E60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE8DC4ED6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D02D5935;
	Wed, 22 Oct 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9cipteh"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25217BB35
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105671; cv=none; b=d7BM8ksTxE32FpRM8XeqWxRES2fNHklulsdXxMiY0kMu3EwyBmN6lX9w7upBAYyfyWucH1hf2sKAYbhn9IPRdGWZS9L+R8Wf99XjuQXrncCiwBtiDK8a5zG+E4CxD920o3wEMT7VCqvWFJysKVdSkWPh94/jIA9xI/s64WTshgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105671; c=relaxed/simple;
	bh=1G25WWOEC3anIDwldLhC009T82/I/q9FTo0jvkxvu+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwCZOC7WhXR4r4M052oIfHH8a6DMp7fT2BHY6prmKgbsipNtIxPyUty67pLhqh/5mKFqP/9+XahZ+f35LQ82mX5HTn4iq3ItZ+KiYGrRdeCrcZ9/sUJ96nCj50Pd4bFVkYTRG+Ef06hZoBQu84FdujMeyP4UjZZX3oly4eRzxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9cipteh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8608f72582eso437040685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761105667; x=1761710467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/FaidQFPNeI/+43osVNZD1Ak2WA6Z3FkGiSqeL52F0=;
        b=j9ciptehjCcGvVkIJr9+EBzgvtg6RLc2ltFexUYf5SER1Ix3122h8dHCtyAkOk77TP
         Tr+SK5Dmbu3cI9MEGacz5GM8qFO+UpYkmy172q4w6P5QbC/XBs29H4zwDyOUtiB5+kLt
         bqVG+J7EpP0D202b6l/GC6ApQDXZ3SPLFfIitMSfbqDLGfva4fOUdZK+YWu/RSX0m2Ek
         hnTw3G5Ve8058Jj9KrGMf2gh+YbBR5QCQwke6JsOSmYadWdxfNvZG6NCrdRyP+Klio+I
         w4TCPrUIwlEu+iJsU/POe1hSyuh+Vzu40p5/x8g+SVNkNpWWVV88R+cd95Jn6V48Ua4B
         vA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105667; x=1761710467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/FaidQFPNeI/+43osVNZD1Ak2WA6Z3FkGiSqeL52F0=;
        b=vK0z6vc3Yl6rcmTWzvS/4eEIb4F2tWEy+C3VKiogM4/wCPaGrMUEBkEzWjLnkd0VKs
         svEuY7lHmMY43jblHMzGSkKc8OT+8VmhpuEagKIv5WyfoFDzsuhejRo0RQTD1mrV44ui
         BNXUOauMgVgj3Att77UHrwtW6/rkDK/YRM7JpUXm1/RQulGADHj/ln/y+o9boV7LkqAx
         uD/a7oXX7lc7zWFpVGB7dmK+8BphbydaS2MZsYpC/g0vUrVYNYNKulu5ufCds0Dg+If2
         Nk189QCwppK3gj8tw9qCR/jab5QllXSpDzOEGONvTWPRVjE13VpcmKVO2BTm05VuaUl7
         hgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWp/41YGcRM5uIVIwYDEOz3WlYw3Pa7nbSbizvOFe5iVc89biJkdguUi07xk9VrbO/UBpVkvBFA2zMbWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBq6ff1d1qgYEKxz7P7VTxt46cjO38lFHSK4RykY6LvWkKM+bK
	7J82br4/DP5srMS38GSMh7i+7IQQ2BFC4kpVzGB6SymqCRjKvGnfrPjG
X-Gm-Gg: ASbGncspOBhbz/bflLiQ8BXCYlo6T6zmSM3ljQt/UHgnRinKfXeux+leN3zHu2oqdPh
	Du+8rmoj+TpGhQqpXdDf1fRmrypSOC8j8QXm3YCIif8qD8n3grU7rY9a2pYcdlgDsbtFMimaDgd
	T2Lc1Br3C8dJiXiM1Y5tX8n+tcDHHOvWEB4vz+AYfNzaLYgrdIVWk6jJS6/RKNZFEsLICqqCb54
	HSiT6RguFUiM4188XuKcAnBzL1qiYhw3Y7GoWKzM7EefnEG62adUnDk9kq+yGE3QLdOrRdFTjHh
	RiNJotu9y1oK/TxIVRFQrRZQyZ46AuJ2FodnpmFmCZsgjhqMCO5fepDo7E6ZwBnan1Y0wBq6xXM
	imzsoJEiHUMR716drnzDLBD7W+82V9C3v/80BfAzQZ9ttv9hm+aWDNyLVjvhHZ/2bOIb63YQvoO
	UzHQVIfKIKUh3Gz0ljPSzCPzbFq4ZfbIJQwGUZSF9/g64jkwRPjydkPPp3lJIHaM+UJQpRK+Nc8
	zcX0jHVAtJ9TOk=
X-Google-Smtp-Source: AGHT+IF17GZXlAb91Jfxy9pTlIJ3D2Nu7E7/sAFEgmx5LdDdbjZVwk2jSURHHw11tWRr3g2S4vjcZA==
X-Received: by 2002:a05:620a:aa09:b0:890:c3c4:3e3a with SMTP id af79cd13be357-890c3c44015mr1786663385a.53.1761105667092;
        Tue, 21 Oct 2025 21:01:07 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm890066385a.29.2025.10.21.21.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:01:06 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8E38F40069;
	Tue, 21 Oct 2025 23:54:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 23:54:34 -0400
X-ME-Sender: <xms:elX4aLC030pik770lyJw1HFjcHhqyIQCuX7ErQ8tEeMDyMPW77U4zA>
    <xme:elX4aHFuicPpkoxsJp5LYea3TsD9TjB9AF0nDmV4PueIgEeCzsQnLRRb0phC9yXJ4
    63hmf9p6YL4aXkHmnQTS0U5veVGGnt5M3cw23anj_2Mcd1fLzkiZvg>
X-ME-Received: <xmr:elX4aAIUO52K9X5OO16y3Lm0NW6YVw4JpKN7pF4k-TBlLKfE10byJg6x3PuVpqgbLfVWWMdQslalBV5OGjkF-y1B3tZiLhdoF8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhi
    sghrvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:elX4aOqOfxPrS7bIQrPHpyMAZ3qgOfzu0OR-QVZXCI1xbLdT_d-rCw>
    <xmx:elX4aHgxagl4-Cqo6mXBsFVT4ONUZjri3TXtJuoL8vKaFsmi-kx1Wg>
    <xmx:elX4aNYrr-a03aKUgmHn6Zkh6_s1le6y0FAnmyQxCd3KfL9kcuPGfw>
    <xmx:elX4aPkrP2c0kHxTJ_QAlMhASriP_H8mB01-84kx2FIVio8gxC8qkw>
    <xmx:elX4aDztK2sXpcUSk_9h29QmgNZW4jSkvB4MmB3vRsc84tpFYLXni4mj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:54:34 -0400 (EDT)
Date: Tue, 21 Oct 2025 23:54:34 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Implement Send and Sync for clk
Message-ID: <aPhVehr_in20rqoY@tardis-2.local>
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>

On Mon, Oct 20, 2025 at 09:35:33AM +0000, Alice Ryhl wrote:
> I added a patch to remove the Send/Sync impl for the Tyr driver as well.
> I think it's fine for the Tyr patch to land through whichever tree takes
> the clk patch, as there should be no non-trivial merge conflicts. Or we
> can also take the clk patch through drm-rust where tyr patches normally
> go if preferred by clk maintainers.
> 
> Regarding Daniel's patch [1], I suggest that Daniel sends his type-state
> change rebased on top of this series (without including the patches in
> this series in his).
> 
> [1]: https://lore.kernel.org/rust-for-linux/20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

For the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> Changes in v2:
> - Rebase on v6.18-rc1.
> - Add patch to tyr driver.
> - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d023320eb8@google.com
> 
> ---
> Alice Ryhl (2):
>       rust: clk: implement Send and Sync
>       tyr: remove impl Send/Sync for TyrData
> 
>  drivers/gpu/drm/tyr/driver.rs | 12 ------------
>  rust/kernel/clk.rs            |  7 +++++++
>  2 files changed, 7 insertions(+), 12 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20250904-clk-send-sync-3cfa7f4e1ce2
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

