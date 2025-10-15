Return-Path: <linux-kernel+bounces-855344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F4BE0F70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E5502E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82130F958;
	Wed, 15 Oct 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/UX29fY"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75F26CE25
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567781; cv=none; b=J0bC5GIUc8hCzu4UfYcvVZd7aLF3P89pQ6TPhsauNlQvNA+D+zkzUJAHEpPjAtLCLha03k6s3hmLFJBgbm88dEQ0DammAoSMTXil1UfDesKOMhBKEzLweOEyby7pT6fQhlGSePr3Rd4iBtWMXe3GWLI5nlN9Hve4oMkQoHuA8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567781; c=relaxed/simple;
	bh=h+MIKm+w0cbUlpRudhd8wZx6gz8D5s8pBBnEVX+JhjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyIf/fhQtoK1MRC+WftLZf2atc9puF7h3HN2GtxhgHbykpV3U9yYUVnkzipwFZ2gj0WtGwNSEQjkFWqSFqFx/aIqnWCkdCVL0wpbFuf730KJpjckb0BUxig2P25LNXy61Had4Q4JUzVJvRsoJ/xxfuQoRfMkjFN6p8O233dQGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/UX29fY; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-938bf212b72so3505339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760567779; x=1761172579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/s3SxkSL7eyHkb5KLXrWbWzbuM7vlN9wwYLs0WQrX4=;
        b=m/UX29fYVdGZExE2N0CbRWUkz/xxLT2F9y1L0UhAckvFNCozrmffx5hTvaqB7uHNGb
         nmYIwabxvsuw7M7Dy4L49XSPzf9Bc2llbD5dtNr+Wm9EGSIn3rvnSGhMR5W/PoV73WaK
         ivV6pzdVxnbQn32sbzhHXZH4Icmchreqf0M21qQgUGnKEJipmRT+gHcwqxfynph0p3Jn
         k/NvURVTyoRCw8ngrloiDw/aP/NtF9rTz8i0haX+yQ/ldR2IO2VB28EcLRHRxn+lR4Ec
         +APZyOCqiueoM7IAS0Pl6jlAuKF+kiE9y8EWxNqygoj48odt9do8BNOrxVcimja/y90l
         0TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567779; x=1761172579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/s3SxkSL7eyHkb5KLXrWbWzbuM7vlN9wwYLs0WQrX4=;
        b=I5/Yt10GcWDmTPEh1yb7Xj1uoX5KjDfsLt8mO5UKHoJMeVa9ckwdKMGKmHawRq8oca
         lkhbZeo/wGjEBObF3PpZPv0ZBJTuZSKUPw7aMsbfc6k7q00+X5KwFanfHl3WBEe8CbUB
         iNSC90Muq/97fHlAUP6b9KX4l2lfAgyTBlxa6+QrncV0G3auh5gvazofvAd4aNwppqqa
         Kg2Ue9oOnvzSOdZnpIYZPC4ZoZEOf/19fh4FkLjCu+L75rXDeb7gM+QU9jRYp1qrF1hh
         fEjUnBwT1XCTsT4qhGPmkWHU0QOMr/CyMIr71aycE9F1h+h+AoJXDZsZzDryQ2YyHCCv
         EaAA==
X-Forwarded-Encrypted: i=1; AJvYcCXUnNbugHU4wnGjtu1rGdrqIJoE7tn7RmHt5Lv/dDbWK+Mu/znlNwlf2vCEWdM9ohCnsNKt/Xns7OX72Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKa83R0txNSPQ69t1jOzR8NOLbLuFjxadDU9X8JJ6TWNTrNSh
	LRzGgBfnsfyDF0DdNp5zERpeu0f3YSkpcdQdd+/j475j5aayu7mW4Hg3wK2KLOvTEgCHhcg14Bp
	pYQPG5xWCYDRceSDK9lbnp8z4ca9dVSk=
X-Gm-Gg: ASbGncs5iOw7cTVnll668EQpWlOPoA9u66HDc1R4eNKqTGiptAKyFCWd5JqTdLadB+6
	fEZaaIDMVe2wUNTl/8z3DsczbGYF+WBGjlk2Xjk1bsYQidXxmXqf+9YO6cYinCRxgDOcEtnTDUQ
	E5VEjsBY8zBrOwTiysCm+GMmAlGD9u2eGBaO+FGxqNHxcOCR0/tkcnyYcYcvBfH7RyIUw5HSRJQ
	yHAC15lQDAx7l44u9UIIwN8BFrqkRwwmTNPrO743oJsPnfHkG0bRWUwRIJVJsc8JSmhvF47Ez1a
	DccUZdj78vQ=
X-Google-Smtp-Source: AGHT+IGtboEau6Bk88v51SDez19PVTOsqLfeOAK8nKqy+9mn8xNBqudys2qDDCtNVqCWa7SL4XVc9GvBu99uBwf86Y4=
X-Received: by 2002:a05:6e02:1c0c:b0:430:aedb:3719 with SMTP id
 e9e14a558f8ab-430aedb37ddmr43372305ab.4.1760567778959; Wed, 15 Oct 2025
 15:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926033502.7486-1-kanchana.p.sridhar@intel.com>
 <20250926033502.7486-23-kanchana.p.sridhar@intel.com> <2qvfjavbepw3sq2pvvcez6jsc3bxkxej27674l4ztfdza7jqaq@xi6qndkj5xhh>
 <PH7PR11MB81216AEDFD10B5BDCBCE1F19C9E6A@PH7PR11MB8121.namprd11.prod.outlook.com>
 <xnwqi5jnawvxdciqapfhhkneynsdr3dx36hmqe7jn4shm3uc3y@iyi5qqfubqey>
 <CAKEwX=NyUR6UE0PhXCaHOdta4=gVvRj7QgZtpPaLADpfXYyvZw@mail.gmail.com>
 <PH7PR11MB812102541D5106A6D0E21E28C9E8A@PH7PR11MB8121.namprd11.prod.outlook.com>
 <CAKEwX=NkaaCkoyULr4J+5-F+L5bRhM0F8JsV2DS0Mk=xYhncRw@mail.gmail.com>
 <PH7PR11MB812150A977B6F9F68ACDBCC9C9E8A@PH7PR11MB8121.namprd11.prod.outlook.com>
 <wn6pnt2nm5pguceiquctilul6lrk3ckycypwnw2zfxqrlgi2cf@5qn32ewswfl7>
In-Reply-To: <wn6pnt2nm5pguceiquctilul6lrk3ckycypwnw2zfxqrlgi2cf@5qn32ewswfl7>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 15 Oct 2025 15:36:07 -0700
X-Gm-Features: AS18NWBiVKuP96cBHxdACGNu0LbupTKRms6mwcpp7-LPrgrL-Jvm71bteOqHTN8
Message-ID: <CAKEwX=NT_3QJSQGRgogGYmx_M262O+F4Hs9BtbCUqK3qbh+t8g@mail.gmail.com>
Subject: Re: [PATCH v12 22/23] mm: zswap: zswap_store() will process a large
 folio in batches.
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "sj@kernel.org" <sj@kernel.org>, 
	"kasong@tencent.com" <kasong@tencent.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:24=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Oct 15, 2025 at 10:15:12PM +0000, Sridhar, Kanchana P wrote:
>
> I am against increasing the size of struct zswap_entry. On x86_64, there
> is a 3 byte hole after 'referenced'. We can technically use that,
> although the node id is usually an int, which is 4 bytes on x86_64.
>
> In practice, I think 2 bytes (i.e. short) should be enough, but it will
> be ugly to cast the node id to a short. We should at least WARN on
> overflow.

Can we pack length and referenced using bit fields? I assume
compressed length cannot exceed 2^31 - 1? :)

So, something along the line of:

struct {
    unsigned int length:31;
    bool referenced:1;
}

That way, we save up another 4 bytes hole, which can be repurposed for
the node's id.

Does that work? I'm not very experienced with this magickery - please
fact check me :)


>
> Or we can take the simple route and drop the bulk allocation.

Or this :)

