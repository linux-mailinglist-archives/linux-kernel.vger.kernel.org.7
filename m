Return-Path: <linux-kernel+bounces-883424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660EC2D65F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA73F4EA0C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21331A06F;
	Mon,  3 Nov 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7ig8eNN"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601830C375
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189973; cv=none; b=Spie0GdYIX2GcGS3BVDYQx7PU3CSLDxqwj+jGOl2eaSNEWZDQuliuc6FJq9co2YIgjcHgfosCZkdozrpwU/qh6owKpPkfmgE/H7ZeOUgUh/tlNIrOjNMmBZ9AzWQNUOiJ8CeHp/rLWdT6DJG3WobQjfISD/cIIgNFmQa+AYRdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189973; c=relaxed/simple;
	bh=kDarkteaSnf10lfwAsM0uNbYYX1j31SFkq5885N1grs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSeEDYD43bzxMORyqolgJopZk3Fpw0KrxD51xdEMVwf3l/AO5tS6LAypE7QnGw9bX8s0r657Tse3jZbJScjdzkLTUmA3kiabUz2yXt1r30vcz3LJg4iwHUiBAMVhgB6yMTW09xAknX1L+fSK3MnIe1SDo13Oau3w8VLiu0ozJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7ig8eNN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so858334566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189970; x=1762794770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L+x6u92PFUYymdltbOhgzGP+ZfkmtaHqsZECM78beQ=;
        b=T7ig8eNNh+V/55GcLc/ThuyhUMfykytyFM46JH+87HC5sN3CdGLKxQQDb+NmePvDCD
         ntBNtXR/wY5jFsWUqoy/qoB9xTErB10EiE86G5X8T0l7CBPOyNJo70Q8ju/yLpsUs8SJ
         bgEgjw3cuF1jgkXkv72fYjj60L7AOv7oD+Shq+kdnYvn1NFyIMfh/iFwASPwuGrm8Kit
         JtOi4typ3vO8UgsELcFjkJrZPXQrcqjnpaKENync7bfHOZwYJUlhcVp6IXRrB4i50p2k
         4uh0p22XwWJ0ysIRTTLHCjgqFDfZMLxdMbW5pya6zvtrw5V31NJKS30yOwG8c+cOFFA2
         4ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189970; x=1762794770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L+x6u92PFUYymdltbOhgzGP+ZfkmtaHqsZECM78beQ=;
        b=X2xhgRVVdYv1D1W2uJnnezi5IlmBTJRJWuaHsBHACq+Zeh1tEvhFHvQ+chhwiANYLq
         PT5DHLryTqQUcwD06EzWg4Jy6dRpqCH+hR9mfXVYXKVUc8I01ivhUTft1fz9OEdSz9NS
         alOVH8S2rsSV0/9Hvzo5xD5IewuWhdzsLy0uzSH/omrT/uLzZdY+xkJR1YvhP4t6msaW
         fI6lJ8z+90pvE7yWtGKB6NedJi5nmHbAIa71hP4U/sHH2mbx5x2haKvRCCSD+OeHIeOk
         WuMC8S40CbxytpMCRmgarQd9+KRwVxKeu+DTRMq+r3787pau27n6EFALX5/tj7jfOmNH
         Mc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWLlWGQPgs2b+aMXotxUv6vz2zmOKTZOLofPoe6pkYsySE9gUR1LtDkstjxivG2H2ChuyRpJvwxI3+jPdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PUsPLFz7tqBgTv6Hguzzn4RCG3p7FXvutinUm4mHzTEiXXp0
	T3ONIDq/oV97c2qxjCYBFZ9IkhwfalhcmS5GxnBGZX5XzZgvwdZ06rZ3
X-Gm-Gg: ASbGncsWexKsjH7Q0NM3os9l6vWArVwgJIGMpwqAgNkJqMQtYuatclvyzajI2JjMFWe
	G5OwxYGWV3440ci4t3wSleDym84NuxRuA7+Rph8+dCwpC7EDPDZORN7VnryyCXzSvBSiYeqTdLg
	tpkq+o5YimKtIbR3ZTMWcXs0Mj0jWllxCt6SL/qNzlk+k6lNTrjTiOM7SC5KYNw6WYVyDjCch7g
	ongkvl03xhwkiAIPIVbG1piWZSO5c3SNsCB/wF1OEBWjTgGtyI5OjA+HS8TxPYIH5pY7N3QGKGU
	siWf+SXTxoKvvrhUcGvb7gf9RhpZVHBkjF0HHQBKz/gYiwDYqyHI1NwIARNv5OrX6bwVZyJCDqQ
	mOCJJfSIhqGqBKn0D5lQjGK8/yYP8HqTbtcw34uPd1Kuaw8V4exeOyJLFntQ+C39mQEZHrXvxYI
	NASGbO87ZQiSF4
X-Google-Smtp-Source: AGHT+IFYSrn3+JLLfbrsA9O3z+gFUcu1TIraVBmewJp9yIRvtZodmEr6n/k/vgTpSkGh5NZ4ce3uwg==
X-Received: by 2002:a17:907:3cd6:b0:b6d:79fa:b166 with SMTP id a640c23a62f3a-b70708b1503mr1195109666b.63.1762189969903;
        Mon, 03 Nov 2025 09:12:49 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c809dasm1075780866b.50.2025.11.03.09.12.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 09:12:49 -0800 (PST)
Date: Mon, 3 Nov 2025 18:12:45 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, regressions@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Mario Limonciello <mario.limonciello@amd.com>, Eric
 DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
Message-ID: <20251103181245.7745621f.michal.pecio@gmail.com>
In-Reply-To: <20251103143851.GA8673@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
	<20251024213204.GA311478@yaz-khff2.amd.com>
	<20251103084021.61971a89.michal.pecio@gmail.com>
	<20251103143851.GA8673@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 09:38:51 -0500, Yazen Ghannam wrote:
> > I have this AM4 system with some proprietary HP BIOS:
> > 
> > [02Fh 0047 001h]               Local Apic ID : 10
> > [037h 0055 001h]               Local Apic ID : 11
> > [03Fh 0063 001h]               Local Apic ID : 12
> > [047h 0071 001h]               Local Apic ID : 13
> > 
> > domain: Thread     shift: 0 dom_size:     1 max_threads:     1
> > domain: Core       shift: 4 dom_size:    16 max_threads:    16
> > domain: Module     shift: 4 dom_size:     1 max_threads:    16
> > domain: Tile       shift: 4 dom_size:     1 max_threads:    16
> > domain: Die        shift: 4 dom_size:     1 max_threads:    16
> > domain: DieGrp     shift: 4 dom_size:     1 max_threads:    16
> > domain: Package    shift: 4 dom_size:     1 max_threads:    16
> > 
> > It seems that pkgid is 0x1 here, which is not a problem because
> > it's single socket, but dunno if HP or somebody else couldn't do
> > similar things in an 8-socket system and end up with pkgid > 8.
> >   
> 
> So is this another bogus case?

No, it isn't bogus. It's a quad-core Carrizo APU with its four LAPICs,
but their numbers start from 0x10 rather than 0x00. And AFAIU, the
calculated pkgid vaule will be 1.

If HP or other vendor would do similar thing on an 8-socket system,
the assumption that (pkgid < 8) could no longer hold, even if the CPUs
are completely real.

