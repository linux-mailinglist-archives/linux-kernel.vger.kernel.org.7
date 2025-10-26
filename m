Return-Path: <linux-kernel+bounces-870384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F6C0A8ED
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C2C4E29A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE911FFC6D;
	Sun, 26 Oct 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDNmgYnW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F11AF0BB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487571; cv=none; b=KRoLWvumBV0XMDV/MX7b434WxwZeJlecgWT0Yx08AqxWT43eJODDMEkwEtaDqUqvlyRcIEcqBMkKr2Ule0AtQGivqy0ClD5LiDH/foiL78cYT642jhMbNCkZ2kOudfqjKgfeuMohcQdTyebirsoYYrMug5vzlrp7iIsMF5kegFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487571; c=relaxed/simple;
	bh=gYfqNtP11KH0UKN4RQH1Rz6mdSU+g18C9eAFYuwbCwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYKmec8EfattvYU5sfx2ikTR7PaoWZgCEpTGzQ3SDC/BgldQ22FkJO5Y3lwULnG5y74CB1QyhrFK0yC69nnN0wzuRq2lsZTMmSuj2ZsHGO1ymHrImhtSBImBsQmge3GhfSPtzTQ9pg8NdAFnNnSDWQJ7AuNqjsBIu3v1unFIH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDNmgYnW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso8200205e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761487568; x=1762092368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLYx4uDhgheZtG8ZPIY5i/GgmjTVBk+AimSR2MYYAhE=;
        b=HDNmgYnW/J8JREIXG+CVkGbLs7NyB02KJ9Z/QZcDnkNqV/TmISojhsTT5juJBs5+Hb
         JbhNbGoUJHnGTNkaxHwnNGop6mEG3vJn5UqevjdbQjIRUNQnyR6Xb1kgicpozqHPhjX1
         keuoAlv0dmwwm6csMF7TAeVSoMatGrgQlE3VgJwZhcgjP3JAfgw6TlXrgGjFB26zhvsd
         sKAL+nJ7tWOkFyw4Bis3egxRhy4KBWYDrMTOAsMV39vzd6IzWzTde2l9FUDe+NcKmD9e
         ZxAq+HVn4HFkDBWIl4wBC6DgyaTTHecvV3ASs8QbwXRyJ7GlkYMH8fA4d8naNVe94iyw
         FxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761487568; x=1762092368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLYx4uDhgheZtG8ZPIY5i/GgmjTVBk+AimSR2MYYAhE=;
        b=sfxBvAPoN02MdDtHZh/GXm/HWkjxInn5WydoTtmUbNUzavdvbSnyo2CYI80X6tKiiU
         EDSlNqtFVn+UczEkaPf3zO3leTUr32GaNbAZdRO01NV+KgqpS6Lc3QfC++cmGHo6Lfjp
         Bo4JZxRYya6xYvZnd2IXJjQkeQzgIlty8K+xjLN63N9GMVKkqvHhJkTFb2AgIvZccAWK
         ptCNGCzRTp5k9PoP+XNcOR/jmSzGCe31X92F8HAVygY352HjEvPAyzAQzd1UPECDnyxO
         DHpfrog6rA2pNzHrgnUhIpzQOYZl3An3PyWeanLbxzuhA50GUZwJzDDealC4HBEURFZ4
         WiDg==
X-Forwarded-Encrypted: i=1; AJvYcCUxyr/zok38pbETXZH4ZV/E1QtBg2jDv3HClSa5dZD02mmMXRZomysWftzD+nULe/hBVANiiLaXMzyEK94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0TT7NU92wFRPWe2qT0ErjQYLz3NDdR9xkZX7Z5Ex7A89IpzD
	HuQlwJxWLGAQH6HPl8A1owZZPG6B27Ahw99AnPH4hbvIDWJvIh5Xmv4r
X-Gm-Gg: ASbGncvJ72AGjgZh3xAcvrRGOiOnvrh6WHUN7zbQSe+9+evrIJHFIdruoixdYeuwTku
	+eyPOU8y74dR6ld35i81iAzfcqNn7/nnC8P6vtkt46DSmbrty46XnvI2nB0gzPSSIQA8FDevi+1
	KUfdPVARzX/IZGufG7SroPN3xBQw2lIIkCek36CrEVCefn0URmfP5qRMS2QiBIlyi4Fakv7sXMJ
	M7hyteli7z/AkPHb4WID6wtZChuYIYv8ABUNuLEUvJ5bLiuo+QpqNfALj2JDqPjQ2K8Y5ANQ75i
	4DHMkLX82O7184MUdFttsAYlA9BFR6VBBb+MsKsXX4BVsT5FnclqD5WyM+hzQBrALWYVFDxJqFY
	UASp8Y0IWTSs0ct6mzr3zYb3nxE6mmQ5R1j4L+0CBjowZ5xoxcdrep5HYVI/vz510ETEF9AuQI1
	SBYbg6PpqQtYouAu+yRnMgv477fL3OlnNYMrQN3zoIG9wxsG5hNh4mLM8K2q3YDmnj4E8R7REQ
X-Google-Smtp-Source: AGHT+IFmodXofCaWJ2V4mG96wHunmtMwZMrtD3TBF632Rx9mURjIzVc1Cf5tYh6QvMESkaUrVCJQVQ==
X-Received: by 2002:a05:600c:518f:b0:46e:4a60:ea2c with SMTP id 5b1f17b1804b1-47117925e1dmr261093285e9.37.1761487567654;
        Sun, 26 Oct 2025 07:06:07 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7? ([2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df6b9sm9139538f8f.44.2025.10.26.07.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 07:06:07 -0700 (PDT)
Message-ID: <72e286cb-7517-494d-a8ed-769b5fb8baee@gmail.com>
Date: Sun, 26 Oct 2025 14:06:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] samples: rust: add Rust I2C sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
 <20251005102348.41935-1-igor.korotin.linux@gmail.com>
 <b09c7c91-b801-40df-8cd8-731837ba2553@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <b09c7c91-b801-40df-8cd8-731837ba2553@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Danilo

On 10/26/2025 10:48 AM, Danilo Krummrich wrote:
> On 10/5/25 12:23 PM, Igor Korotin wrote:
>> +impl Drop for SampleDriver {
>> +    fn drop(&mut self) {
>> +        dev_info!(self.idev.as_ref(), "Remove Rust I2C driver sample.\n");
>> +    }
>> +}
> 
> NIT: Please use the i2c::Driver::unbind() callback instead.

Thanks for the feedback.
I’ll move this into the i2c::Driver::unbind() callback.

Should I send v7?

Best,
Igor

