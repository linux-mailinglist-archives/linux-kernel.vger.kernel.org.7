Return-Path: <linux-kernel+bounces-859486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049FBEDCDB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BB6427B64
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 23:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2D287504;
	Sat, 18 Oct 2025 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BZ6S2Xs4"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E601279DCD
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760829091; cv=none; b=XqvOAUgbz99p9jBrm7UqGp5ksJ0FpCApMTrupSTzCevYVpgOjCkTRphwP2UYqx1EiKlQwWVBAhA3uBJWeJCoNNHPzUeNDdhPziiSjtatrdOLoh0fOXWmsHrca2Vp+tdsTk2M0zA11N1yYolQgXhnCEEH6B7pg41YvCDkrK3Wz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760829091; c=relaxed/simple;
	bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD2SE3btcWW2fBRl3aH0Dp6B0EifQUdmsYu4zCPrLJA1I30de2+wOgoyN40b2tLXwwRIU8vmWVNcNFumItWtgwn0SjvMkb/xBv1lPnQvqs42GbTgfEm6Z30dYasPBv/pfYMtkVDzznXosTg3+OAlu6twKQKgqWqPN5CCxFAeXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BZ6S2Xs4; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c2878bdf27so938528a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760829088; x=1761433888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=BZ6S2Xs40U9WQeq7NwydR9GbhQbdvOjDSv4Qbr9KKeCYizlk6xi5vEFooSbU8ymvLl
         WSBq5lAT1yCWnNc6H16VrjD0JeAdPqqNvYBxmG52hVSP/t1bdV0YhO0yBVZQ+S0wsrpY
         /QPFLN0zDpppP7ApdEaqJsD1GF7o5OP+bYGjdmMJOGm/Kt6tuFeThxoQFTLzXKtqoWHh
         CteSEOebSSDXqi99VukwnkUrG/AMT9Obl/oLUprKxkOT9lYdjoQ17DHql8pZX8V6Y37P
         TrqnH3iTSdnsI1yr9Uoy+JIq0ccrtZoBfQcv+rDIlNoL4H0lhLQyB623WY2d67VJJy9j
         0TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760829088; x=1761433888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=EHYrwHysIIe+ZF5ky4trQ4VHKDqmtevlaPzjW9DOVFVb0DcrhOoRDRP+KqCbhx7Kef
         kDcb7LVc8vtEHEMEpNIxQhkGShNX+VZpCjfHZ1G/SWGl9MVogStY7PQI/I3gPYygOHET
         liIis4PWKiEcDP6LvXUP66XbpLv/hrT0nKKorF4nLMH90xgBqg0BB6vokDgdS9LXeEfG
         5cjaMeeA6nNjpDy6WN0pyPue2ZWoZ/34/mfOZx/M3GITx7/U74KwAh91OoxY5gN4Bg2d
         XWCWl9Nurki0/fEuF8Hv7w8LtzBUr6ZiQmfnJFmT2oL8fyXoMzJYGx6eaQir1oLUybi3
         Zt0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0VeMSaXVLt2s5xv0+SPZG2vXat3mZb9bp5xZCRZ0O/Yab1vIdqHiAIWFv2OVVTkfzind27KOvKRRwsAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWqDywp3bAib8fuagJFfvemyCLrUszgdww9wrXf6hZT+NLhyK
	wV8j/aDhOohsqIb3WyXE1kI25QVcslESRv8WcLYKQ9Ng4MNgBTjXQx2ACCHaoERmbns=
X-Gm-Gg: ASbGnctGa6w5kjD0g0Kxd1/Ybj77zdBeoGKI9qkhS/VFR51W9dUhP6DkPZeYjQcs0MM
	M+hhK2Gz1UMeXkreURjan3g6LUOLNBCWwRzSbpwAAINN2HBv3BATBRtnIj+xPxk4a5NoPhfEO3a
	Ktt2v9F0b+WTkHI+QU5V12u8NVeLhOcIsRzWLRmGVphvpilTtsHbTmXyWZewsIqAUfLWTYk48/2
	j0KM3eD4gJgVvxpBTIPnod4C6WG4UBUJp/g+ZBjiyDzRHc/CBk2XYQjXsEr0oq7N/r2r1bvDLh7
	ZPs14UZgymJ7r5G4kUTkmKQNe4CV54zovQmWNiHr2ziikOW2pGQykjnEq3TWDslJN+NK1B5uVRP
	WNCNIEIhJ4Q3DgPnU8lmKLUoaWExjGRnDrMIYJ+o3r7Tl0iNLxqYL8FAmV8W/
X-Google-Smtp-Source: AGHT+IGjutQW9FOpunwPbl54R4lmphJmatLWLrvDMN3YzWlbvrTlVJ+kuMrXHSfrl8ye5jNWMdw9aw==
X-Received: by 2002:a05:6808:2388:b0:43f:5fc5:e04a with SMTP id 5614622812f47-443a30af9cfmr3465468b6e.31.1760829088069;
        Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651d3f8d640sm899440eaf.20.2025.10.18.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 16:11:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAG58-00000001dfK-14RB;
	Sat, 18 Oct 2025 20:11:26 -0300
Date: Sat, 18 Oct 2025 20:11:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251018231126.GS3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018223620.GD1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:

> Having __packed in my version of struct, I can build validation like
> hardcoded offset of members. I can add version number (not added in this
> series) for checking compatbility in the struct for serialization and
> deserialization. Overall, it is providing some freedom to how to pass
> data to next kernel without changing or modifying the PCI state
> structs.

I keep saying this, and this series really strongly shows why, we need
to have a dedicated header directroy for LUO "ABI" structs. Putting
this random struct in some random header and then declaring it is part
of the luo ABI is really bad.

All the information in the abi headers needs to have detailed comments
explaining what it is and so on so people can evaluate if it is
suitable or not.

But, it is also not clear why pci serialization structs should leak
out of the PCI layer.

The design of luo was to allow each layer to contribute its own
tags/etc to the serialization so there is no reason to have vfio
piggback on pci structs or something.

Jason

