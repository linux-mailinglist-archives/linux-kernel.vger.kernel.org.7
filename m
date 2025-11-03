Return-Path: <linux-kernel+bounces-882559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C031C2ABAF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8343AFCF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC42EB866;
	Mon,  3 Nov 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cX26JTlt"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF42E9730
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162047; cv=none; b=Oe1U2u/DNKNKgpJTB8XaZZ24T6VXI90VSn1Eaask3R0Vf9OPx1cxEojiYtVARrKutXLcnyic89neVLNzAxYYZmRwKagSQB/xnvyvlZHsmCly+fOwQgBLUrJW4ubBr+TmwzUW0oabKQxNOHSoENZ+xY+vSrOy24Uh3Vr3BVPEd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162047; c=relaxed/simple;
	bh=2T3Xdr8r17HKPsoSbydWvx2P/0UQkjcbi4HlQeeoIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLJZ9IUlrEHuF8C1yQdyi4MvZUVlX0LhuwlrO0lWwgD4kIZsAczC8ktybuG9mlaPshLFttyE2q/5KAiaCJOwMp5DB/xKKQgW4w9mh2zu9OCmUW01t/fbqqphlm/jk9oasRJg6HcZJ9Dw8TL2j3coQIa5G054eh3MBR9jE9UvPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cX26JTlt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762162043;
	bh=2T3Xdr8r17HKPsoSbydWvx2P/0UQkjcbi4HlQeeoIew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX26JTlt2KnX/6F7uTKQO9FcOk7A1K96Eiq13lmAV/5tTRMiwy1tVolHrqylObJyS
	 VWyynDHgDG0O30/+ir8D6a0em/Lf39f8hqSvhZlGvjOm9hvSwE+u1VMpH5qClIDwmR
	 Cf5oy2dIpccho2VwLPvmfedtZtecZZgN/vEoZXYI=
Date: Mon, 3 Nov 2025 10:27:22 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: ptrace: Use UAPI types in UAPI header
Message-ID: <4f8402e5-2bfa-4ee3-9123-fac887ed866d@t-8ch.de>
References: <20251029-loongarch-uapi-ptrace-types-v1-1-5c84855a348d@weissschuh.net>
 <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>

Hi Huacai,

On 2025-11-03 17:12:58+0800, Huacai Chen wrote:
> On Wed, Oct 29, 2025 at 11:20 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > The kernel UAPI headers already contain fixed-width integer types,
> > there is no need to rely on libc types. There may not be a libc
> > available or it may not provide <stdint.h>, like for example on nolibc.
> >
> > This also aligns the header with the rest of the LoongArch UAPI headers.

> Thank you for your patch, but could you please tell me some history
> and user guide about the three styles: u64, __u64 and unint64_t?

uint64_t -> userspace type, should not be used within the kernel
            can technically be used in UAPI it will be somewhat
	    nonstandard and introduce a dependency on libc with no
	    upsides.

u64      -> kernel-internal type, used for regular kernel code
            defined in include/linux/types.h

__u64    -> UAPI type usable from both kernel and userspace code
            defined in include/uapi/linux/types.

As a note: When applying the patch I want to clarify the commit message
a bit, as nolibc indeed has a stdint.h header. The real breakage comes
from a validation step we perform which does not add the libc include
directory to the include path.


Thomas

