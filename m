Return-Path: <linux-kernel+bounces-723871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FAAFEBDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548A656540E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570D2E175E;
	Wed,  9 Jul 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="v1YkWv1y"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9019F40B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070820; cv=none; b=ohZP6K6H4SSiQx79BnMQogcLf1v3Gc8nJqzgCShwSLrmnWlS8vFeVCPm1X3RPTPtTJ/kENLNi8ySSsPjDGfNoEoWZ3vnAcRPu1JhlS8yxHQyOoSI2krGdf28u3NtjN7yrkZoRgKZmdA24PRpaNblEn5+XOVFrdYJWP57KkhkFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070820; c=relaxed/simple;
	bh=izxYMRmyjfLaPNfclpcKRt2rdXsw9LASTfTgnLOH6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzepyLFof/ib4pliMm2wyXGGJtlDTicvcBx+N3T57MhinzFjDfcO/2db7O/bVf8zYvih+ZGWizQ6tepQxTgwXe971VQBdCpCVVQ9Pv5pVmjnG8eEHj/F3t5NohH6WLcfDOknzm37caeg3dGJwnbOi9+4z+LycZVs+1aubQputyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=v1YkWv1y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d3e7503333so853392985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752070818; x=1752675618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oX966d2OnnOsVdLSRaxq3GIDCek+Q0oewFnZOwTFSCA=;
        b=v1YkWv1ypHWlzX088QHdk05jmU60OSahGqNq+dTw9byhfKmU5kztGxG+zB/gfMsbl2
         r22Cd9XfmJ0errB5DUh6SPxIIfyVbW1QuEC/zOWta+2DDSqqICeOsfxpM6I4HusKZx6Z
         iH07gUNbael2nKNc0Dvp9xmts1qrmH5XhND3XitiYyjumPAJOxCMNm863Y/F5EQVqUnI
         I4CrEZnaYlXhwzdEQUL0UH88uardBTn0JNxj43qhTQ1dQuDq6h9wUOjmSEqFLQxga07D
         V1Tr7Qk7DEmoc9aYu1aWrUWAgF2Rs5bL4z5p6m2TwBT0itgBQlVEgZvktIQ1gHQ1mcNs
         HDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070818; x=1752675618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX966d2OnnOsVdLSRaxq3GIDCek+Q0oewFnZOwTFSCA=;
        b=LYg/pQZ7+Pw6gMRHHAt6PIhHbYMi82x4PMYhzebCaOwhWjbvNYcLz41NyUm+TZ8HmI
         qz01QZvL4Ci8oSqIcNUhjP1M0VraJNpiSXe44N5XJ0EJLJwI6+DghMKROIGpjlO6Q6Ir
         SJKQXHqMrGKCpzUDT6DqWLB6AixcR04p06oXHM0aq+obHn6d/MpHFIHDCPB6fK29Fd3I
         lNYBMUAtOxg5sWLNZZgN3PTVIxxAmEuxeI0anYgv2aFMIQCmpvlILH6hnnAbvn6QDe+x
         MtSDt4NsnXHmKWRG7wQEwcaVuybLJIrYBLmg9ZIire0KKAAZ+Qrxk0dLs6enTKoCZLS6
         5Gog==
X-Forwarded-Encrypted: i=1; AJvYcCU0TuD6s37vhoSoTBR4Bp0wrb/V2keWyFn4fV+4h2Vq7cUgXAcgFOJeORJHRYUsSZTp7V71tZXEZ+HnN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9FUTRCZB/6ceV7XER7uwp8wPQiPWvjdnfXzyvZGm+kPMIYX3
	hARRYEwlKNagaodVHCUSWyxJoT+jgQTq6hKLvYiGYx5fE2aBRj0cP0BWevefhNyQjA==
X-Gm-Gg: ASbGncv6Zs4hS2n/aGGjLowzfXqhIIJrpdaV7t/wxB3mug5x5CxlzXCiug7QayH4ZIR
	06OWdHHB4v4YsB3FKfTlhmyIqIM5P7oH/ZTdXdY6+wLNy55xVQwxT81PPqLxB1y+88YBY2olnIm
	qExt4SUDhEEn4eM3+GhiWT33aUQSW4Hlc4FbfIkwGh1+lwT2Fyp5v+90iZyDe9CUX0IsfA4cqxU
	F8SH5BaR/9/yelkMDKyie7pIbqLWY/bHZjlnTxilrzLGNb0dVEtRLXf6OwLD9vWsPyw98l6FcFv
	DZNigX3w5V2EpCA4pFjweIbyrW6SCNDhLToErb1yJ1WEift3C+tO/f6Kkl7p6ObDWW+8Kk8qXFF
	9Me+b
X-Google-Smtp-Source: AGHT+IG/uoOVNhIZcZGNS2qwUCpBTImqcv5OllmWRSz3tFYzjY/AZyQcMy3sAMZ5fv8ra7bDAqxtjw==
X-Received: by 2002:a05:620a:192a:b0:7d4:57a5:9742 with SMTP id af79cd13be357-7db7d3a5cdemr333724285a.39.1752070817522;
        Wed, 09 Jul 2025 07:20:17 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f9a5sm936291585a.87.2025.07.09.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:20:16 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:20:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zongmin Zhou <min_halo@163.com>, Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	zhouzongmin@kylinos.cn
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Message-ID: <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
References: <2025062004-navy-emboss-4743@gregkh>
 <2e0bbc5a-e74a-4fb5-884c-686dbaf99caf@linuxfoundation.org>
 <48ab511e-2847-4daa-98de-a234b8584b78@163.com>
 <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070949-activist-mammal-b806@gregkh>

On Wed, Jul 09, 2025 at 12:06:57PM +0200, Greg KH wrote:
> On Wed, Jul 09, 2025 at 05:07:24PM +0800, Zongmin Zhou wrote:
> > > > In fact, I've experimented with adding PM hooks to the faux bus,
> > > > and found that faux bus devices then behave identically to platform
> > > > bus devices during suspend/resume.
> > > > See the attachment.
> > > > 
> > > 
> > > Thanks for checking this scenario. No surprises here.
> > Another part of my purpose in doing this is that the vhci-hcd driver seems
> > should still retain suspend/resume hooks. Therefore, the faux bus should
> > add corresponding hooks to allow the driver to call its own pm functions.
> > Though currently don't know how to fix this problem yet.
> 
> I have no problem with adding the pm functions to the faux bus, BUT it
> needs to make sense as to why they would be needed at all as this is not
> a "real" device or bus that should need to do anything when
> suspend/resume happens.

The unique problem faced by vhci-hcd is that the devices it controls 
reside on external computer systems that have a lot of their own state, 
much more than ordinay USB devices have.  Consequently vhci-hcd may need 
to do more work for a PM transition than a normal driver would.

As an analogy, suppose you're running a program that has an open TCP 
connection to an external server.  If you suspend your computer, it 
won't be able to send the TCP keepalive packets that the server expects, 
and the server will eventually close the connection.  Then when your 
computer resumes, your program may misbehave when it finds its 
connection has spontaneously been closed for no apparent reason.

Alan Stern

