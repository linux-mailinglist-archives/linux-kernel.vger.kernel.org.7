Return-Path: <linux-kernel+bounces-872285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF41C0FD57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947554F1D52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893431812E;
	Mon, 27 Oct 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjRWcGor"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9D2D73B3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588074; cv=none; b=klXi4VOaYGr5rWRAvq+CCT11CpaCrihtNy9yl15dZWWtPpnNi626ZTJvVhaAl+/+yNbsLvq+26YekTjtEni2F2v4qYtKPyOdL3sVBSBYYZh/1lff9tgZsJdQrRPjzKikgFJPoEGXMp1z0OeYmyyCrGI49galn4p4IDfknNod4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588074; c=relaxed/simple;
	bh=dSzQwak3RBPC5y51ILTWEaSZmq/yqlFp0KvonW5s3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE0jmIRWaAusuV3b1di6mM2+Sj2fY6fPH4BRnzFZUgmP+FkV5w6XINOhfcOy9T2ouHK/HTkWnhGbzxyGlagvcDEqNfl7eeZaW7mHCQ4qy3NKcYFQpRkZQ/wfKTYqoSht+CC5hBZnI+JKwzBy0Nsg6Qo5blpWiELBMbMc+dqeoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjRWcGor; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-784a5f53e60so59264317b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588070; x=1762192870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=NjRWcGorYJ2t1TNHCJoSB0Z0ydloHtrfZ06gOJt1tG+ON1eWeTZo3TtgHGBK+DwJQa
         XUseEvwA9GsRWU5z/VR78PiXJStbuGjjPDQ+ClGtuCMdkwiGiZq4wH44Dt2dS+52D4E0
         bx141hMG7Qn87LKrn9WOMEI3gis6Zk7TBaBa8oI84quy1T6VEUcz3Q20z7zZjQMq2kZI
         NJC0rrGZ7l5kIGd2bSI9ydoA8Ll0+ZX/eQSJwyBLrKe+gMHlsBE74syQxM8T2EWJ0GQ4
         j6gENU6VPCZkiyHO7TcfziL9n/x1TIaVI1jZi8KvqoQMF1FADchbAssaAXQaxF9UiQDj
         Ko5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588070; x=1762192870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=qz52yJglA7XFSKn4u98IH3uoHy8q6oLijS9EGT5Hbx4rHiPqlwajVSnlNx0NkgqWEi
         zaZkdsuEfOKMK/fRz9jHc9hurks49sg4HW5f1h4DtFNCcfrKPA+tMoUfKib5VN41jelh
         zIFmKYsXr7eH/aBGsYuH9Cyx3sgVP6jmk0Jt3/WL6rAaWVVyXCKM5Msb0cTHLkS7M45z
         ZN2gRPPIqZltt2/zcyYacKg5ldNZRDKxBVbGwVDluiSQuFwvP2ZW+Rwq2giqPHld3HvZ
         eOPvIFAP3vT2qVrN5e1Rvo0vpAtLUDrKEDxt2EUIv64yW0QR5k6JSlR99BPqht+xMhNb
         jeYw==
X-Forwarded-Encrypted: i=1; AJvYcCXGZji9tq/1F0lzFUREeehPSSqDMEM8TUG8iI32DQ040E1QZYoO8e//LhEiG/wt1oOMD+ePV9YDoFcwzWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IXUYwwet5ySaAusbgG76RQIwpIqzZ5VLaOv58v3oXphDmrPg
	z6Wk4RD4jlWtEb8PYate4glDSRqh9tuKbxw0y8ffM51OSB6i90sNkReQiqnaLBE3
X-Gm-Gg: ASbGncuh7kaM0DuKZo9mFvHe//QrM8+u4BW9sWbEq4pjYgIBRx/9OrYsXd4NAt4uZwA
	EtHw+f1e+aIudT/IDTr5SAW+T7PDdk+RST2rqj6X6Zx1iePFBOPkE95dGZIg6NsQ6OTxXymntQW
	0/v9gCiqyET2hky31CFLNVAI+xFwNIOIxVfiS/wXCUR61V0MhY8uQbzRxUCAS+V9kGG3Hw2sBpH
	eAnmPTp6rFvrZVBd5P8GU0J2kbyNNGwtk2VyoQzF4a1vyjOzGd6a1vSbQCTY3p34MmzIX384lnq
	76nwDDD6iedcixMYTlVN6brAuLcdA15eVd816MhfXYzA33nnwjtWOI67gtaVeNLzYUSCb+vmRkt
	86vExb48DYkrYD+WmgTSsFWvHJqzyblnReusXmyGJIcnyhgnZlMCMdCC9kzvr1c48ZF8jXau2UD
	+idPbqfHiK7pmwb8WSkHNhne+QoZuC7yyYtJx9FL+C7MhMfiM=
X-Google-Smtp-Source: AGHT+IFWDCi2g1kdSTmc4R6F+QSoxN+p5e395OCPC0UeHMIqjdYpQhTxQQ2O31gfhQCi3Ezja/+T9A==
X-Received: by 2002:a05:690c:4d4a:b0:76f:8f07:4908 with SMTP id 00721157ae682-78617ea3e56mr6919087b3.27.1761588070172;
        Mon, 27 Oct 2025 11:01:10 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1b24e7sm20674147b3.35.2025.10.27.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Message-ID: <aP+zZMtf7FwwmqVF@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
 <aP-keSURBFPZvNA_@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-keSURBFPZvNA_@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:57:29PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:08PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Change QEMU to use generated pidfile names instead of just a single
> > globally-defined pidfile. This allows multiple QEMU instances to
> > co-exist with different pidfiles. This is required for future tests that
> > use multiple VMs to check for CID collissions.
> > 
> > Additionally, this also places the burden of killing the QEMU process
> > and cleaning up the pidfile on the caller of vm_start(). To help with
> > this, a function terminate_pidfiles() is introduced that callers use to
> > perform the cleanup. The terminate_pidfiles() function supports multiple
> > pidfile removals because future patches will need to process two
> > pidfiles at a time.
> 
> It seems that this will no longer cleanup, via a trap, if
> there is an early exit. Is that intentional?
> 

Yes, intentional. We're trusting the vm_start() caller to do any cleanup
now. The assumption being that with no "set -e", vm_start() should be
able to return to the caller.

If that seems too bold, we could add some function like create_pidfile()
that generates the pidfiles and registers them into an array that is
cleaned up via trap.

> This patch also changes the handling of QEMU_OPTS. I think
> that should be mentioned in the commit message too.
> 

Sounds good.

Best,
Bobby

