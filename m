Return-Path: <linux-kernel+bounces-850545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E29BD3242
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 529894EF462
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C972EBBB5;
	Mon, 13 Oct 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUBY8U68"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009F251793
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361007; cv=none; b=koXyh1n0LqWEUPJCKDadXVYCLETU4hJ0khBbGFA3evxLtzPeYXGem3JBsSG/U8EyYGz4zWglW/Muj2k1HgYq7c146CjHhIVbuDyTLanbhL5BRH8h+SsHRgy0nIXMYJnYa2rXosa5p8WSwUwYKoPHw4PY9imY0yptc4igbje+dEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361007; c=relaxed/simple;
	bh=AUiRVZ7sMn1+4J7dgwP6Hsi8FiuzPSM5pFCcK2UnPBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO2vcOpUusKgZVgopKqOzS4RKOYq4C3SxqrOnWLo4kwNEAxTL8IPDZbkyzJD/IjJMA0ElXltQxaR3kz/0UvDhWflMGShMvenmksnxGtrDdnI1unrGCC4CqK75bzVYywErVj1c+QOpy/7KMrLf1cO49qN5kkcgL39M6AY6w/7XaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUBY8U68; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26c209802c0so40432205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760361004; x=1760965804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eM8SzoY3Ga6SPnTiQ6Z/fETrx3sjrihdY4C9vGThuB8=;
        b=HUBY8U68SFD7l/322Mqdk+uq9Pn/68+DU6mp9aw72vS7mgBX4ZFK4d9Ol5+QtqOQla
         dsFnKYcTr1V2STY7ekUy/DFk1Gp25O02y1qaRamHqJI4XNSNzpeFjRyG/IaPrXyHiA70
         pIVyabyUwYHgwX7Hyo8K/40gi4LCyV9wn55dO/0tTiFuaDSVRNmDQ3e5PWBUgMcTiARb
         Lpai2cveNqr0wr7Ia94b2pKxl4vNZ1VmAseLbT/1Dl10Gp0pDKhgKxgplei/9EZTHNg1
         9/QlPIF6jYjnq86MKHqaMg8wnuEAG39SBr9C9WZzIvBtUmSjT6+yMrtL3O9dZz5pFONB
         D3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361004; x=1760965804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM8SzoY3Ga6SPnTiQ6Z/fETrx3sjrihdY4C9vGThuB8=;
        b=J+LJ80yUgcKuvS350nGOoavKi9a7kT7b6ELCSV5SxcLO+K9Z/gTo+K6sJYKgLTG4i3
         Z8LYKg8qSnBdzEPCLnETG2u3DPf28qEDoiZ/B7CJAKhV64OwXu0L5irLOxneDSxxOOD5
         Sb9laDN4MUepimvSxrfnO//HIhEdq05rEhTDfWJieMmUiFtaS2i3nrnmYZ+tUpSsEGny
         56sEY2OisZ3w5Gqkad5hkayziTu2yY/smnUzpeaBij1iKnvgi3ivIfnKVeumZbM8Vwk2
         uhVEJeqeUHFxTwxAVIO9TEjTrsJFS4D6PMeagoJkLBr/m+n62iLA0E9zSnyHHbLak0sm
         T8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZW5yROCLGeMNhxacsr+bV8qMRLG2TuOmH96Ivy0I+1PA6CPYmNE8Ux+e2AVfLqv3NJU8KSm4RahpZdUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKYQPqo9PVvLm5lt2dnovYEKy8abJh7XasXYyzhh2PQdpIhZV
	mt5AcoDZxDF1xMbS8K1Fem0RO+HvKyOjLRUuvkYFmboDFtd638FR8EqZ
X-Gm-Gg: ASbGncs6xSWQBZaANa//HB8R5Y/GeKEwz4xeGco7FeZQGgSTHVHpFRLjHpTIP+bQYft
	9ylf903Y8Rey99ysiErU+5uAQh3Fiwcfn6CREvgaqldg3SiFOFgdiLr2cSsuoWLJn0yxkvBP4Z+
	7WrVQffzOFnAeW0pb5E/juVapMGQFTBzVe2hlulBCzfnhuS+gtcqV3RYkmnlH5vYQwaTkAlDIJQ
	2mPYuJQ815wYLy9SDWG/x0bkkEoMXLGcJXmyz2A9a3JpcO39of0Q+OY0Vdx5E2I7GuH7KvbF08O
	2LhF1Dm7AU28VTSvGw+kvKbevjMGryatka3HsyNutJoW47xDQWO1GtT/B6B/gTozZvgEWaeJTzH
	cSRlhuDdHTEXYMCL3iUaeA+Gs/F1FbU+aRR/rQ4+3EstF8xvtaEnEIc+ILx5QrxCT+OrRBsgOuf
	8iIu6m4PzjXcujaizAw8mIr+qMgpM=
X-Google-Smtp-Source: AGHT+IFIBnpgJRFRAaPk2BVssrOVcF2oXu12DR1cAuTUDGRGCwwUQHQKIvSdHF1KGnJkx6jFK6hxNw==
X-Received: by 2002:a17:903:2ecd:b0:28e:cc41:b0df with SMTP id d9443c01a7336-2902741fb25mr227013765ad.61.1760361003606;
        Mon, 13 Oct 2025 06:10:03 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08de5sm134550965ad.83.2025.10.13.06.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:10:02 -0700 (PDT)
Message-ID: <79cebb23-5232-49f1-a0ac-b401707c2b52@gmail.com>
Date: Mon, 13 Oct 2025 18:39:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/xz: remove dead IA-64 (Itanium) support code
To: lasse.collin@tukaani.org
Cc: skhan@linuxfoundation.org, khalid@kernel.org,
 david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20251013115136.16773-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 xsFNBGh86ToBEADO5CanwR3XsVLXKhPz04FG37/GvZj3gBoA3ezIB/M/wwGdx6ISqUzYDUsB
 Id5LM/QxLWYdeiYyACQoMDYTojfOpG6bdZrGZ2nqTO/PY9tmY31UyEXg5lwZNGnZgV+Fs6LW
 E5F1PrndB4fGw9SfyloUXOTiY9aVlbiTcnOpSiz+to4C6FYbCm4akLaD8I+O1WT3jR82M9SD
 xl+WidzpR+hLV11UQEik4A+WybRnmWc5dSxw4hLHnhaRv47ScV8+M9/Rb42wgmGUF0l/Is4j
 mcOAGqErKo5jvovJ4ztbbOc/3sFEC42+lQG8edUWbk3Mj5WW1l/4bWcMPKx3K07xBQKy9wkf
 oL7zeIMsFyTv9/tQHYmW7iBdx7s/puUjcWZ9AT3HkZNdALHkPvyeNn9XrmT8hdFQnN2X5+AN
 FztEsS5+FTdPgQhvA8jSH5klQjP7iKfFd6MSKJBgZYwEanhsUrJ646xiNYbkL8oSovwnZzrd
 ZtJVCK2IrdLU7rR5u1mKZn2LoannfFWKIpgWyC//mh62i88zKYxer6mg//mmlvSNnl+A/aiK
 xdVfBzMSOHp2T3XivtPF8MBP+lmkxeJJP3nlywzJ/V038q/SPZge8W0yaV+ihC7tX7j6b2D2
 c3EvJCLGh7D+QbLykZ+FkbNF0l+BdnpghOykB+GSfg7mU5TavwARAQABzTlBbmthbiBCaXN3
 YXMgKGVuY3lwdGVkIGxrbWwgbWFpbCkgPHNweWpldGZheWVkQGdtYWlsLmNvbT7CwZQEEwEK
 AD4WIQTKUU3t0nYTlFBmzE6tmR8C+LrwuQUCaHzpOgIbAwUJA8JnAAULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRCtmR8C+LrwuVlkD/9oLaRXdTuYXcEaESvpzyF3NOGj6SJQZWBxbcIN
 1m6foBIK3Djqi872AIyzBll9o9iTsS7FMINgWyBqeXEel1HJCRA5zto8G9es8NhPXtpMVLdi
 qmkoSQQrUYkD2Kqcwc3FxbG1xjCQ4YWxALl08Bi7fNP8EO2+bWM3vYU52qlQ/PQDagibW5+W
 NnpUObsFTq1OqYJuUEyq3cQAB5c+2n59U77RJJrxIfPc1cl9l8jEuu1rZEZTQ0VlU2ZpuX6l
 QJTdX5ypUAuHj9UQdwoCaKSOKdr9XEXzUfr9bHIdsEtFEhrhK35IXpfPSU8Vj5DucDcEG95W
 Jiqd4l82YkIdvw7sRQOZh4hkzTewfiynbVd1R+IvMxASfqZj4u0E585z19wq0vbu7QT7TYni
 F01FsRThWy1EPlr0HFbyv16VYf//IqZ7Y0xQDyH/ai37jez2fAKBMYp3Y1Zo2cZtOU94yBY1
 veXb1g3fsZKyKC09S2Cqu8g8W7s0cL4Rdl/xwvxNq02Rgu9AFYxwaH0BqrzmbwB4XJTwlf92
 UF+nv91lkeYcLqn70xoI4L2w0XQlAPSpk8Htcr1d5X7lGjcSLi9eH5snh3LzOArzCMg0Irn9
 jrSUZIxkTiL5KI7O62v8Bv3hQIMPKVDESeAmkxRwnUzHt1nXOIn1ITI/7TvjQ57DLelYac7B
 TQRofOk6ARAAuhD+a41EULe8fDIMuHn9c4JLSuJSkQZWxiNTkX1da4VrrMqmlC5D0Fnq5vLt
 F93UWitTTEr32DJN/35ankfYDctDNaDG/9sV5qenC7a5cx9uoyOdlzpHHzktzgXRNZ1PYN5q
 92oRYY8hCsJLhMhF1nbeFinWM8x2mXMHoup/d4NhPDDNyPLkFv4+MgltLIww/DEmz8aiHDLh
 oymdh8/2CZtqbW6qR0LEnGXAkM3CNTyTYpa5C4bYb9AHQyLNWBhH5tZ5QjohWMVF4FMiOwKz
 IVRAcwvjPu7FgF2wNXTTQUhaBOiXf5FEpU0KGcf0oj1Qfp0GoBfLf8CtdH7EtLKKpQscLT3S
 om+uQXi/6UAUIUVBadLbvDqNIPLxbTq9c1bmOzOWpz3VH2WBn8JxAADYNAszPOrFA2o5eCcx
 fWb+Pk6CeLk0L9451psQgucIKhdZR8iDnlBoWSm4zj3DG/rWoELc1T6weRmJgVP2V9mY3Vw7
 k1c1dSqgDsMIcQRRh9RZrp0NuJN/NiL4DN+tXyyk35Dqc39Sq0DNOkmUevH3UI8oOr1kwzw5
 gKHdPiFQuRH06sM8tpGH8NMu0k2ipiTzySWTnsLmNpgmm/tE9I/Hd4Ni6c+pvzefPB4+z5Wm
 ilI0z2c3xYeqIpRllIhBMYfq4ikmXmI3BLE7nm9J6PXBAiUAEQEAAcLBfAQYAQoAJhYhBMpR
 Te3SdhOUUGbMTq2ZHwL4uvC5BQJofOk6AhsMBQkDwmcAAAoJEK2ZHwL4uvC51RoQAKd882H+
 QGtSlq0It1lzRJXrUvrIMQS4oN1htY6WY7KHR2Et8JjVnoCBL4fsI2+duLnqu7IRFhZZQju7
 BAloAVjdbSCVjugWfu27lzRCc9zlqAmhPYdYKma1oQkEHeqhmq/FL/0XLvEaPYt689HsJ/e4
 2OLt5TG8xFnhPAp7I/KaXV7WrUEvhP0a/pKcMKXzpmOwR0Cnn5Mlam+6yU3F4JPXovZEi0ge
 0J4k6IMvtTygVEzOgebDjDhFNpPkaX8SfgrpEjR5rXVLQZq3Pxd6XfBzIQC8Fx55DC+1V/w8
 IixGOVlLYC04f8ZfZ4hS5JDJJDIfi1HH5vMEEk8m0G11MC7KhSC0LoXCWV7cGWTzoL//0D1i
 h6WmBb2Is8SfvaZoSYzbTjDUoO7ZfyxNmpEbgOBuxYMH/LUkfJ1BGn0Pm2bARzaUXuS/GB2A
 nIFlsrNpHHpc0+PpxRe8D0/O3Q4mVHrF+ujzFinuF9qTrJJ74ITAnP4VPt5iLd72+WL3qreg
 zOgxRjMdaLwpmvzsN46V2yaAhccU52crVzB5ejy53pojylkCgwGqS+ri5lN71Z1spn+vPaNX
 OOgFpMpgUPBst3lkB2SaANTxzGJe1LUliUKi3IHJzu+W2lQnQ1i9JIvFj55qbiw44n2WNGDv
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <20251013115136.16773-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey all,

Correcting the mailing-list again,  from linux-kernel-mentees@kernel.org 
to linux-kernel-mentees@lists.linux.dev.

Really sorry about this.


Thanks,
Ankan

