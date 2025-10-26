Return-Path: <linux-kernel+bounces-870276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F1C0A591
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3604E3BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB45288C0A;
	Sun, 26 Oct 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj/eAAOF"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D717A303
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471519; cv=none; b=CXL/rBeYrlGN/wK5zj1eYgJkDk0RXoG90oh7nT10OEnXv6XPWuLf+9g1eCzIO2n8wTlOCeOxsLZxq3bOtHl83uDkT2ScYk8w6bm1yuVvefkzIjQhXvYssf+3QavY6jexzSvBHtKb4c/pge7IU91kKtwgA9tOaDA5/hGoSWqsRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471519; c=relaxed/simple;
	bh=BlGELhvKOBCcUK01cT+hHszOs7SJMhq+zuaurlP3kzw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jBfiLLDTXHSTPgn3qVT0Ps5V92XYLIWokWkJ9kuNSYZCRqWL6/+HiH4WtTGKolILuJQ/ACO1vFm4+z3TJxQrGwwiTKp4QYO2D2bR2wOCZ14rA+eNr/74Dq0pma3gQH+nEQ+uq9RaBHzSxTPFopFtS8p5CidSfPWPvIcD0dPQooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj/eAAOF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3296749f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761471516; x=1762076316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlGELhvKOBCcUK01cT+hHszOs7SJMhq+zuaurlP3kzw=;
        b=cj/eAAOFm8UR+TjUspS0+9/+KI6GIZFDVK4Ls6unokE/vw9yZ+Ph94oKB+CC8Z3VEq
         Ctagx/7QCj9IAdc9Rz74pYeIUXNkSLKBiNA1HXUZIQmSmkVgpYhNqY0r0SocHYJPFh0F
         4foA9fP9ewmuc+4nSWY3EzDW0LuHSwyvrODj9zY7p152h6q8hP3ZCRbTYUHe4GK5VvfW
         goMHnztEdDJRPS+51nxe12jicRVKobl7i7qiLCetvaS3qjOj4BQFJfxQfle5LAxQMrOj
         lPlsIAtvv0MBF7V4AInkalLvKqQAMMOuaOvfKKTW0WFySEhVQhn1E40xIL0Q/sRbFCHA
         TMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761471516; x=1762076316;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlGELhvKOBCcUK01cT+hHszOs7SJMhq+zuaurlP3kzw=;
        b=WqYfG20pxVGGaQZKmMGJr12WO59uKe+Y6WgDa1USLx9F9CeFsCUD51b6ppzraGnT1G
         u6R+FR+xkN8ODrYmDEW3jf58LQwTNsDQUgGL19rPB9HMyaOBPa3wxLlkWhOsh+7Hj7R4
         YM88Om+qcR3EZ1p8OYuW/BXZlImg7PLXJaiwA7mkLCaSgtHY1JkxevHjdH0G7bPSW1wB
         bQkOnVqnB/eOTsvSTl2J/9pUpWrxsXZEQUu0UlDGta1avF2MxIqFMbf+pt4lPPPpi/i3
         ++zsVKlLnuw5GYydHSoUpYn9S352XXYSv0BYnoYh4bJAVBa8sV/kPw/UZ6LWW/4/B/rL
         fP9A==
X-Forwarded-Encrypted: i=1; AJvYcCWcxnGk7ff0M3FgTLkmN+D1aRMnX4x+B+BJYy5Ro3f4qmpRASRhXREzcy56vcvxIOWz+R3geRtB5MqV5k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/WxVbpgtFzuv2ahCaZO8oUxmanM6C6hqu9EB5spSCt+NyJTo
	towP80k5PnLJMivIEUxSoEggucw9EWloszOYetpMgr7EbbA547Z5JNUT
X-Gm-Gg: ASbGnctg25V4gDPBjDGdrhIXwAtrexagslBlCSg3ax5bud8e0TYLnJmJVGOi4K6Eywn
	DN0srN+vv0ZmFYKidF2XhjHS3NtcJyWCSV3ZNywhGhq97GxgNFSluY0Uyx5Cw6ziN5sB0R50i3q
	tv8MwobSHj5SVNJ/0KIdBc1hOfgKcRFfeJuGuHtEU63HamXkfAjS/2J5AdwqkE/Zs97nGe4KPgP
	XbA0I3fN48kg+922GDHQ3CMy/tbE/k2h5wNqkkJ5dC/0bN3CbW0OYuKKTBF6goH/hZkF8+m9uId
	BAw8LaVJY2dA0Ok98iLD0NnJfp02T2UQABeNq8es17nahFrkiWpjslI4FK/fA0FX/6Uq/VLHNC2
	/3catWH8sD6T+Jmn53sVjO6v28TaAfQle7mAL4vDAogTTaTnaci7dHoNMP9UZ5QCtrunOGxujH4
	9FyNmrwwwJuV6UQ90z6FAKdeykEYzGIcliJiOdATVxHEc4E8UNqHoi5QsB/wzeQbOBpxuvYPBm
X-Google-Smtp-Source: AGHT+IEjnKK7Q47TzLdAeD/BIWXcqdHCINnF1PkJmHJElS4u7hTRXmg/V24ilZ9lRzYDGAOsD4o0tw==
X-Received: by 2002:a05:6000:41d5:b0:427:666:f9d6 with SMTP id ffacd0b85a97d-4270666fa57mr22885765f8f.39.1761471515642;
        Sun, 26 Oct 2025 02:38:35 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7? ([2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e21sm73364465e9.9.2025.10.26.02.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 02:38:35 -0700 (PDT)
Message-ID: <4d6d737e-6e9d-4d33-8402-940947170872@gmail.com>
Date: Sun, 26 Oct 2025 09:38:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] rust: i2c: Add basic I2C driver abstractions
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
Content-Language: en-US
In-Reply-To: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping on this series:
[PATCH v6 0/3] rust: i2c: Add basic I2C driver abstractions (2025-10-05)

Just checking if there’s any feedback or if it’s still pending review.
Thanks!

