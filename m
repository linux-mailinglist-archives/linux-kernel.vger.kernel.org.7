Return-Path: <linux-kernel+bounces-771466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD71B287AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA75AE7485
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEA218AAA;
	Fri, 15 Aug 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="U+XNxhzQ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAEE1E2602
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292993; cv=none; b=gbgd4sbpT3bmi0f+30vl1HzIU7SjJTDwUG15BLZAM3Us+jV9fLYQjsqN5/wO6g7jLAj/o2UNAF2Bnl3Vl196zh/mSl8nHOPOlr1sJdPCHYgtEpdB1KhC/rFD/bdmA14aTKcej3dQlcUdEZDPF1jJ4RTzjGRA579f9s9Gjjo8pUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292993; c=relaxed/simple;
	bh=rL2fitm+tS6+W9pxtYj3dx/LtnDXe554uFTjYGxrTZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX9R86Pciij6k1geOKLaoRB9GZYCMY6CK9vDJDSlUMcu0CxYNZTYporMTPQWOYPCfvaMUuvrJAzCXvksXGAS1IKDrQ5VUED4Ppnh674xO8QE7MA2I/ImuJJ5NVv0/KblxdwCH/+BiYmyZgTuW+N2NcOz/BeOp5AIkar4D4H32vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=U+XNxhzQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e57376f661so8637235ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755292991; x=1755897791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkCGU7vrJ7DFla5aXCTXd0vDs1VIB8T5w3DaNMZ0OU8=;
        b=U+XNxhzQ/oVDGmSsPcJdjqpWp5DJapxa4sQbcUJUOm3W6nTTBH6TAJheb5t9ysch36
         MKamB6TIlt5gH2OhLpCRCyyBcGkhfYh7C/fxOF6ml/qdhIIo8T/PsfN7pywWizRZaSVC
         sS3CG+EHDFQKylzODBFBFUY/+JdXo3mN6NqkzkoFNzZaYboESAWY7UE186IqStHya8vD
         ozfqEh9hb3JwWQ+VpGbcIvLm3sAvL8jymKivvkU03OS1zmnmm7f0iooAqtvTHFzzFVFI
         3vjUxl65hVaIUDvgHGFzY9rFHLlK1MpwZcSMw+GEidujI46rDey7ynrTWG00hG32JGO5
         qM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755292991; x=1755897791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkCGU7vrJ7DFla5aXCTXd0vDs1VIB8T5w3DaNMZ0OU8=;
        b=B+AymIfMitGa/CrNHCkh6EP37TMkl37NNbLIJcLomgcYIPlq0lKsBEryCVL5rrLDRN
         11GZdjX5W3kgqg0BXR+7XgGbIT8hjK+UD6mzuqQwlm0WqduwspnbLvZloJ4d/E6iyFJl
         kViOxvgJNTAO3aLPSdooURRZubAa+Zgl/LkZl2MgyEFd10RVGGcw72XRM/3bjtKljZ98
         EsYNkOgZNaCccFc65RmMEHuxqWuC16ll3us9tluAcn28DRBkrSQ/1iaZJLBb7UAn+418
         NdjmUuhYQnsrRXvEiKxiFBofQUAPOQKssIcY/jKmiAjQSOSMSmQVUfQPYJ5oodHwuflK
         GgHA==
X-Forwarded-Encrypted: i=1; AJvYcCXU8dgn67fIlmD62GFDOjilCZZwgvpdNJH7TvZ+44gJ4dysjuJxERutODpt3Q7hiQFycktzJi5+5N01wyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGBZFeZnQ20DdCkbg5qcp4zou2fOUizAYfL3DaDfd6tSZSVyg
	VLx0LHn2yPQWOw+Wga1U8HFjN8uc3q5y17XgvlLqCpzqic6PcswNU0vxwNIbPvkYdKE=
X-Gm-Gg: ASbGncuRAAT1/aEfCbYx0k4mw5C5Kz7lKUSkS0ey2XMQcDojPMs3HSx16rfb9DHhymo
	1A8NI9DODVDRZ0D8elASZWhT4L6nf6VDc0Qzz5E4Pdk4B3QM8Hl81tYmbd4ajzUlo9N9q/veevI
	SuV6Vdj+xidLnGi/dWNIe0f0wM8X7T/9hSnCVgqYjMKpgzio8ms9H9qiTjHEtm46gA9gXaUX7Lc
	FvlAIQf06LKu0YJhCG3ni4W08CpbyafX6S2HUSFGnjHND0ePI9wfJ91kmxILkS6tIuvDMTTEwru
	ySP5jrMhQwhYVF8XS+/dBcAdu6wUT2Se1yhJ3/2P2kc6J96guPgZ19BZvQetnE6O8+JWad1HSie
	Au2/oxgNay98Y
X-Google-Smtp-Source: AGHT+IGOp9pqa7yNmPp64kIzhyF7IB2PIDfMU+q5BfpPSHoLfXYQtuamRMAjyJZp0218S+l/ER8bWA==
X-Received: by 2002:a05:6e02:3c83:b0:3e5:4842:c522 with SMTP id e9e14a558f8ab-3e57e86d2acmr59871085ab.10.1755292991281;
        Fri, 15 Aug 2025 14:23:11 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:4e6::7d:7f])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef32sm653514173.19.2025.08.15.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:23:10 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:23:08 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC] Patches to disable messages during BMC reset
Message-ID: <aJ-lPAc2bLlvHNa3@CMGLRV3>
References: <20250807230648.1112569-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807230648.1112569-1-corey@minyard.net>

Hi Corey,

On Thu, Aug 07, 2025 at 06:02:31PM -0500, Corey Minyard wrote:
> I went ahead and did some patches for this, since it was on my mind.
> 
> With these, if a reset is sent to the BMC, the driver will disable
> messages to the BMC for a time, defaulting to 30 seconds.  Don't
> modify message timing, since no messages are allowed, anyway.
> 
> If a firmware update command is sent to the BMC, then just reject
> sysfs commands that query the BMC.  Modify message timing and
> allow direct messages through the driver interface.
> 
> Hopefully this will work around the problem, and it's a good idea,
> anyway.
> 
> -corey
> 

Thanks for the patches, and sorry for the delay in response.
It's one of _those weeks_. Anyway, I backported the patch series
to 6.12, and the changes seem reasonable to me overall. Ran it
through our infra on a single node, and nothing seemed to break.

I did observe with testing that resetting BMC via ipmitool on the host
did kick out sysfs reads as expected.

Resetting the BMC remotely, was not handled (this seems obvious given the state
changes are handled via ipmi_msg handler). Would the BMC send an event
to the kernel letting it know its resetting so that case could be
handled?

Best,
Fred

