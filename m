Return-Path: <linux-kernel+bounces-846741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D990BC8E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E7C4E1BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173292E0939;
	Thu,  9 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RwWMI0NL"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7E2D6400
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010452; cv=none; b=ZpiX2bpo4/xAHITfB1UxdgYHUAVtir0L7/ObYaUyyEvsy6JBvQr0VcWect4gSHLXMesh+yfQMHfom8aO2HiavdwTyuVCA3rJQCmxHYRMgqE7tMBIhFr85vfbaVNnWyx7ZnRiC8vKGlxfZDhK7hnIgjD/h1wH5Hkfgo+YowVUjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010452; c=relaxed/simple;
	bh=botvLY+e+FH2/AeSnmon31xjDAZfoMaKqDI6wcu/lts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKqnicoLGdNoLwnx/d8FNZkLdTfIG2xRRLA/S0xCeBZdHxxkjDu7T9XQAOYCG6ur1+1DngbltCLrKpCY8tlqdEgFDz4hXgc7lKajQUmw0FB14IQrgxnMjQLXLI6K64b8DWFKE43NCA0hcfz17PhPMUC9nGrAHnaQ/W2RcUOoDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RwWMI0NL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07d4d24d09so156040966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1760010448; x=1760615248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=botvLY+e+FH2/AeSnmon31xjDAZfoMaKqDI6wcu/lts=;
        b=RwWMI0NLNTHV/xCq7Euvd8syWK4VVKur+3UW2pcUWo1dMo1trYpVUArXhgNoflCUYK
         0xt90q6nDrk6r7SO6BUqA5HaUQh3crlKZrWTC/sM7PQLHy8TJyKPtmSl/UAohRLns1IV
         XoOlvc9GYykZoA3aJpF0b1W8KK+hCEiD1Fqq/aqB91g/zHpUW2GgOTkf2fQNgJ+shzXy
         /nBxSRcLIfugB8kYTGV6WUf2hGhJnYP+TtQPvYeeg56nTorXhA4vx7itl5iITYf0j4cO
         9R0Ha/r3cxioNVEVHKXRvJGyYUy40cox697MLy/iXjfH135qMzhr9y190/1xx+Ad0lYw
         urRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760010448; x=1760615248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=botvLY+e+FH2/AeSnmon31xjDAZfoMaKqDI6wcu/lts=;
        b=uOwBsi3CIG4rdgm/oP+p0T/wJeXP6hOGzowI4uY5XbYT4exuaOAQmfrhhyKLvnYX/9
         d2oNUwNjHVffSss87PNJXi3XG8gdy+0lmEayq0SIBrE5ZoH42nyyijBYhc6BJYlH7xRQ
         FysgVIRtLyT/nglFsrwjleakjeDwhQbfRQ3x8tVcL0FnwnUr+D3gAAfB1MEo1uueIiSZ
         dWFhHs/660CyMR3cOijIobyaAT2aQ/DwUCHGb1rk0sBQIN+iD2Jn+g69OI/rBXh8dFGZ
         Gulb8V4HBfd72B1p+v5qgNkoaYT4jUs2A2E5HYltidpE095iB4Ipazf1rAIxdTUnZ4JL
         SG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYtSpTrA6kkrHu3SQWMYvkEZk52wuszCd70gQncCfc/+Vevui1dJOJhbH950LtQ8eGSWW7b4d6JscHPxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4riZp1a9yRXhoW9nphTQ0lHkCXl6ohlZ+1P23bzGL9xZ0Td3
	08p0158rqdyHTm3xdi/snhWIqNBZi82wP0010DaWxhLRHzOpPpeSuLnav6a1kUc/B0Uf9aSBaf3
	8kATqEIcI09fmHWT0Ddv5ieBI8Fmhd+cAR2qy9128rQ==
X-Gm-Gg: ASbGncsbZcTsHwLRw4oYUkshVwzYSWBYeubfUONIkAeoprpHLJlfJWvqWS1JzpRmK3F
	uaFMJ+lbDaoEiAiKuBiX0moOrUEnZvA/pJ2V28kgzBCAKzj/Xae9R11Ap4uafCWbTWlogZtDLFA
	iNP2MwsCkaxIb5wwO7m3S2WwFh7bpYXRL6rWggYK4BLA/SStAmhzWmo2NM1hPlK+wfeBOFgMmAT
	JEGRjQYMFQwkT8f5lw9TgS+if4fi9iVRh9ebOzd/X/EnAoDPTH+2CBQwvdC
X-Google-Smtp-Source: AGHT+IFO+urlLmzm35on4CiyvY88G8vAyiB+vH7kV4tutVxZBb/l4yIKAnTc99ekEVr5OcqAJELs3grkW6s9boBSV70=
X-Received: by 2002:a17:906:ef04:b0:b3c:8b25:ab74 with SMTP id
 a640c23a62f3a-b50aa393c32mr837268866b.10.1760010448499; Thu, 09 Oct 2025
 04:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806094855.268799-1-max.kellermann@ionos.com>
 <20250806094855.268799-4-max.kellermann@ionos.com> <CAOi1vP_m5ovLLxpzyexq0vhVV8JPXAYcbzUqrQmn7jZkdhfmNA@mail.gmail.com>
In-Reply-To: <CAOi1vP_m5ovLLxpzyexq0vhVV8JPXAYcbzUqrQmn7jZkdhfmNA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 9 Oct 2025 13:47:16 +0200
X-Gm-Features: AS18NWCi3x367EpbmrZD1bATsg0qYy5Ho_fotqaUYHcMI-fpgH0tghRfYUXXHdg
Message-ID: <CAKPOu+8a7yswmSQppossXDnLVzgg0Xd-cESMbJniCWnnMJYttQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] net/ceph/messenger: add empty check to ceph_con_get_out_msg()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: xiubli@redhat.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:18=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
> I made a change to net/ceph/messenger_v1.c hunks of this patch to
> follow what is done for msgr2 where ceph_con_get_out_msg() is called
> outside of the prepare helper and the new message is passed in.
> prepare_write_message() doesn't need to return a bool anymore.

But ... why?
Your change is not bad, but I don't believe it belongs in this patch,
because it is out of this patch's scope. It would have been a good
follow-up patch.

There are lots of unnecessary (and sometimes confusing) differences
between the v1 and v2 messengers, but unifying these is out of the
scope of my patch. All my patch does is remove visibility of a
messenger.c implementation detail from the v1/v2 specializations.

(My end goal was to have unified multi-message send in one function
call to reduce overhead for sending bulk messages, but I did not yet
follow up on this idea yet. The Ceph kernel messenger, just like the
user-space messenger, leave a lot of room for optimizations -
unfortunately, my user-space optimizations that I submitted last year
were not merged by the Ceph project.)

Max

