Return-Path: <linux-kernel+bounces-833426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC63BA1EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3AA1C846E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9012EF673;
	Thu, 25 Sep 2025 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egrNLCPB"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860941B21BD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841874; cv=none; b=sujbjjWBOC/p0AdwmputQrl0igVpgDhZl6iqWhLI261FpQ6Qq0Vkvp6KMMvrwUQDxDFjJv+LqxpPFbFuUcRaXkR5Jc2mMat/gtc+TogfIwiwikyN4qxOeKXXufzyyFZ1xu1LGNKB4BMeFGRXIKQ+fl9dFZ/U1lY+m+5oC/iLq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841874; c=relaxed/simple;
	bh=oiHIXUdOzoglW/J/URA4pqKW9gVAeoSDgnoqWqvaVfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e4ddYWhCG7/vOqKF7o0jZYyTu8WsbbRqe+znW1j/bkgI/2UEs3uXV+jiwEm14/4GRLgUwB9XwmvII49xTPVQzA5juv4ZvtZPbiOF/OmSDgcqaMsLGSpDAPc8mwVo9ND0Lm2dT+vWZ/GyxYnB7mdjPK2SU7AMjVUm5XB1/Im7WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egrNLCPB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55443b4114so1064344a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841872; x=1759446672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZVdaxLJayRqBqAukZwC+iQh85lmBt/BHPIqP75j3Is=;
        b=egrNLCPBmlVTjRhL0SWFvVsjWUKvbabxDvqP7kSNQyzE6F+eWcvjtD2npxEKNWkfwg
         TLBkm81qjm+08BZtSPIFuHbzB88I6YRIzh3/nxkp5sCkyceHXQI8FeNfRh1I+WyxH+Ii
         0GIMq8ec5fl/715UyONCpY2BN19b6Cst4xIEpz8X+zey8xeiA+ODXxcY9RvksFzc56cp
         HoxYx2uXFQXQDQZv4YLoRjMh47gSZZKjY0gdN9E3dZ6tVOe+oWtPS3FnmXjqmBQJk8oh
         bponUrRjtuqtx3K8v0m7t2Xh/Qy8Yh/gMzm2HaFkBcaixjkQhN1gUbEJfkwTg/YplgNT
         EEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841872; x=1759446672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZVdaxLJayRqBqAukZwC+iQh85lmBt/BHPIqP75j3Is=;
        b=wP6UMyrFMemAv6olBTHaanC2b1BcT5a3NGVcq7sh13hW/p6rxY5YGdOEXEzmXnPkRU
         ltsa01cE6LEf6eDwynBZ6djx5OPD0lD8fLSCQe95IaHZJSpa67wEbWZhZ4rSv5lCU48R
         Im6VU7Nno6KB79cBmoOUfBKMpzyhWX7xl9W8K5FijKfrWjuSxCeI7WTh+Xhdqssa3UNx
         hKPCcXLRPMW1eQM1ZX3fqb9YQg3khDRxb6BdAgxJoom06RodsoBBx0O3kqVeD1oThl0x
         Me/ZL7gC7PPfHCsL03Y/LnCGu8cCdjy0+wOgjqFMA44LaNI+h4FhcvrsjJBNgwFNo9SN
         A+7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFaiKG28C75eNJoQDRAFccvAje9B4N5Jgh22xzdYHh+QZtFMN9jtdZsPDI447UJt7cK2PVfH6TlScsq6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwFL6GTtbqDXuh3fCGSQKN9JL5I/ZTbxBcX7Ex3eg0fGqKkQf
	yh+qIC8fHZTdIT5Fnz6Wcrfr0Bym42cgfTrdSUC9u050Tb7fPn5wKkYsyTuWPDAyyP28R5sav4q
	uWK0kHw==
X-Google-Smtp-Source: AGHT+IG+NPU2qzuwg0PGrrB/m6E7PdEwbL+V+1OtFuiNFwEedivOk2ejs2Itl3jzbN5NqkraND+qW0XXbL0=
X-Received: from pfbfe12.prod.google.com ([2002:a05:6a00:2f0c:b0:775:f353:e9b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:338c:b0:279:90c2:f890
 with SMTP id adf61e73a8af0-2e7d5f3e361mr515910637.59.1758841871840; Thu, 25
 Sep 2025 16:11:11 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:11:10 -0700
In-Reply-To: <aNVahJkpJVVTVEkK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
 <diqztt1sbd2v.fsf@google.com> <aNSt9QT8dmpDK1eE@google.com>
 <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com> <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
 <aNVFrZDAkHmgNNci@google.com> <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
 <aNVahJkpJVVTVEkK@google.com>
Message-ID: <aNXMDgeFqhWJPArm@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Trimmed the Cc substantially.

On Thu, Sep 25, 2025, Sean Christopherson wrote:
> On Thu, Sep 25, 2025, David Hildenbrand wrote:
> > On 25.09.25 15:41, Sean Christopherson wrote:
> > > Regarding timing, how much do people care about getting this into 6.18 in
> > > particular?
> > 
> > I think it will be beneficial if we start getting stuff upstream. But
> > waiting a bit longer probably doesn't hurt.
> > 
> > > AFAICT, this hasn't gotten any coverage in -next, which makes me a
> > > little nervous.
> > 
> > Right.
> > 
> > If we agree, then Shivank can just respin a new version after the merge
> > window.
> 
> Actually, if Shivank is ok with it, I'd be happy to post the next version(s).
> I'll be focusing on the in-place conversion support for the next 1-2 weeks, and
> have some (half-baked) refactoring changes to better leverage the inode support
> from this series.

Shivank, unless you really, really, _really_ want to post the next version, I'll
post v12.  I've accumulated a bunch of changes (almost entirely just code movement,
naming tweaks, and adding comments) to better prepare for reusing the inode support
for in-place conversion.  The in-place conversion stuff is much further out, but
I'm hoping to get a refreshed RFC out (with Ackerley's help) in the near future,
and shuffling things around in this series should help avoid too much churn.

P.S. Thanks a ton for hammering this out!  I'm especially grateful y'all took
on the inode stuff.  It took me several hours to wrap my head around things, and
that was with your code to look at. :-)

