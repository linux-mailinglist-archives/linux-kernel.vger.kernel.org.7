Return-Path: <linux-kernel+bounces-867593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA4EC03109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD34EC205
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB629827E;
	Thu, 23 Oct 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCJLiySW"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9935B120
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245387; cv=none; b=A5z97iTDCYBXOVPUSU6Z0XeL/2pnKaE0LVnR1X/+IxSRzBs8SXP4C/KcmzY4P799bn5wcv4D7+UZ5M2+TlsgVqNlprh1c1e+2RS2d0BOjXiCxJtwhiA30XN4y9oH3UI78isSJzbOihJL+xHXVTRQNeWGOl5SO19oH92Dh3FBQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245387; c=relaxed/simple;
	bh=2nd652PUMtxe+A7zqF5Bu33R+D4iWOSC+2cXUl6RNFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ7HJ9xIWJcr0cw+rJBwYWePGFxXZhZG4XiXM55IhL/PSGuxd6Qelbhi/t+4fi2CHEFZZuV6p2M5X1aYbgUR6CTkJG7F9LqJoxBl4p2ZDs1EuERNUBgs2gYJSRDD8SFbkWJNALstTRgSevopBrLAOI81kQpuzQERuuZUctr6e9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCJLiySW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427060bc0f5so700960f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761245384; x=1761850184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nd652PUMtxe+A7zqF5Bu33R+D4iWOSC+2cXUl6RNFw=;
        b=lCJLiySWsMWv1TTM2/BoT7K5IgNE/MpGt/1RJ64Dx0nKmGx/Ar+5NHLQvoMGmRsiFF
         sbmmSh4Y9R9396AzIfwXGEnaKuiLpzcRqY+/nuT4b7qBuMh0EmuynADsEbJ5c21SUNuv
         BhEnYLa0NdqGYyD0Nu6mcZl5Q+QGMQJDEBH1YrAGUkrynrPJz5dyY4ijQ9h8FAlQs/Rx
         D9jvftHhkmVtB3sWfeK4MdOxjDscP+W/jrfXarAAiVqQFPDjHY1um//6wHiqzOilO6m+
         l9Ugw4Z2H9AQfN90Gk+Os/kYtmBRBwJL5UZO/uBgNKK039whq9xeGbpAkUpnjryMuR/d
         iF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761245384; x=1761850184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nd652PUMtxe+A7zqF5Bu33R+D4iWOSC+2cXUl6RNFw=;
        b=OWlklckSyO4XsNJACRghKHvou3NctFE3b+Eda0/+qTfeqxQWQDlrKlUPR566QvhGf5
         ZZltMARHDjyAk4bsE9YdSeuUFAVIH4Lp2xOtgSCejfNVVEOgv7MFOkZTTqreqMYfxbYI
         CIZBEzw6B1nsfp6R2XSa36d+68JeTAAzCRCGmmC/6MN7xXriZx+WFdvvRallUpDHWfmp
         z1L4xndAj/OwIWvf0/HauNo4MD0WRndGCElFpdtmjTrz1LfOOBaZpYH6xCTbJDXJ8/Dz
         +moqKLXsHH33dK3MI3K5z3s/rWlgIaPrxmtHAWEy8qKjrvgL4jHaCJQoX8b+kIp+eiu8
         hoGA==
X-Forwarded-Encrypted: i=1; AJvYcCXlh9WknlRj06cPgZXi32hjJ2gEiIVH/JIIBPOjKGVF3PbGhQjJGpJcEoCxHsYcB+0E3HklC/+Qy5QUKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+O2IrsXtDexIzzBhxjSGVToXQ1FomWNX2rnYvNx+0azhi4Zl
	kec2UQDz2f5tDJ+epC6DfGRpPtxP50ylCIcNGxIr9IZ9BmYBodupaL5PyZZW9kZ4JWbeAf8VjDP
	dqghKn3b4XZGSHA7G779q5lqjHldGedE=
X-Gm-Gg: ASbGncsVn1KlQ2Bc08RXQjPVw8tW7DPbR/756ay22oEsBnMts75EDQ8XdgHszMFqeBn
	agOPairn6E5YK9sIlq/ZkrGjjwMLyOY8KQRqMqFh820iQarxtGd5qj1C30VjyaURjb1HKeeGkWa
	ePbIB24ERCqPS5INgqoidYbj32d8DIB6iR7Cz+OTxthfXBTfBZuQB5i+juNIEE+DZJ6iK0Mkt1c
	YrKTBoOxwThEa11xKEsqoV6wWFE9blOcVFNseH184BoqkRVkU6RHtktQUeDAxQVeUzl5x1e76Ns
	g5tGREa/mZ4=
X-Google-Smtp-Source: AGHT+IEeHRMJWPv3/iVJ9quZ//H+bz+8QmjfPzxud/29WWYKF0dtb/o8Ka+b/OD/RMRH+3FeY1cruqwGT5+h2lnbztU=
X-Received: by 2002:a05:6000:2405:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-42704e0eed1mr18520576f8f.58.1761245384235; Thu, 23 Oct 2025
 11:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
 <20251024-swap-clean-after-swap-table-p1-v2-5-a709469052e7@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-5-a709469052e7@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 23 Oct 2025 11:49:32 -0700
X-Gm-Features: AWmQ_bmPTHIQQvWwNe5YWL2_sylNwTUwWHrORzXS9fyw3tv9sd81xVKAoFs0KoI
Message-ID: <CAKEwX=NO3v_rMcjkUHQuL1GjxnNCZPceYrL2Wm1C6WaHrJcM2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm, swap: remove redundant argument for isolating
 a cluster
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> The order argument was introduced by an intermediate commit and was then
> never used, just remove it.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

