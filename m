Return-Path: <linux-kernel+bounces-808122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5200AB4F542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F4D1C26463
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B5732A828;
	Tue,  9 Sep 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVrefgRv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481D32C33E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419832; cv=none; b=dc5AL/SMZXNMTvv8OK57wOrWm1Tta2lzzModR4PE70HAXF0fOveL7QjesJwoR2dP9nwXFZ70W1u63knJ3JK2+kHuWH9dN6Ppna/bKb9VjhWuE/PkWXgWdIZNhTKOIYueZW3+x7wK1o0ignDOKgFn+hvWeXL0MdsFsFRySmQHye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419832; c=relaxed/simple;
	bh=POQ+KrDMZzWUCA/637U0YCLhbicOSpe5n5QI1q7mb84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLTUPAak61rqiOE2pJGtqEl8Xj3heuBn9AIBiwTRuG83LWkfht7TrNyZI3rISp/Nd7Wt42aDCoT3F2Nrz9yeAuhnmVxpZMM1Y4IPBx6UrXFCK00r1KHqmHH+jYHOG6MqK9OgiKjR9zbAv82UEOFiRo391XJ7oeMl3vFAlBKovPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVrefgRv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so35288815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757419829; x=1758024629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WMhFn1C+Yx6W2wpeHv5vlp4fLrLgkTAzBM0vbXLgCo=;
        b=wVrefgRvUT8rRksfSnZreHt72dTzRAG1hwOmA/voNnx3pQRdIyTucOh8F3JgnBEnQR
         FXuob5wOyqr1ePi37m3pC93uH4FcGa6TfSfXV3AIek0PO+7ocy9KKjuyEVWa883/ouYm
         uWff02aV5psLyt7EH+k+ka6bP1bUqmzpmIiw6YXuyNO5khxA43k2RnzLHzblNad1k3tq
         bWoTBwT8Wyyl3he6/Y5MNq+7m+/qjI/N350lgZpDe4uAHD6HELALy/WIAtmWX4K+uqRr
         dAZy9jT0baNPYftmSq3NqUij6L/OvOVnaQjre8crBwcM2hjrpNZhyAAuwB/M8c8k0/uB
         uKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419829; x=1758024629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WMhFn1C+Yx6W2wpeHv5vlp4fLrLgkTAzBM0vbXLgCo=;
        b=jKHURS9Dj0b3JlgFRE44mk3u9/N1S0yilCm9S+/DPQX6TbnFV6vROHdvdKN5LRN2H7
         ng80SZTtB3AxJY9QrHSkXcqBxxZYwqLTmMTHmXs0fN1PqRHuFrcDy+F+X/8tXLpBDebk
         KA0l0CmlPWBIFIxupdJZtDL/NeN2JJnR6UDVd6ta7rdHMqCiKDe3vSiBWe68TVRC2+5G
         mM/rgSW6c9NnNrub5YXxVomsF1kAlM29Qv6vVTcYgAFo7GAaextdFeZoRemUVEaB5BGa
         bjN4scrrhmA5+WuBbkIKdo+94dFO+CctL00iDleFg1jZcKayX7Z2RmGbzvF5gmyAm/Ro
         OtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUFzXGxk3+aLhJibjxZYIDkeRgdu3tQQo08L4aX+HSfWB+Cs9fm72jfczLLZU1xwrkFDj89S+TMEdvWY1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WuG6WwTbMGXHNl0K+4r0kF4Fl+Eyv1JCPEoujWXq++lCtJoM
	UCZKvkWzdBS3V9yfqOUHrdOJpMIDESZX7D4E1VEXytFRPn9fpZI9DYmy76BxyRrtrQ==
X-Gm-Gg: ASbGncs18rSHg99VMcwcatDwbZmzqUEdoY5YX307U71btyVP1+L1nacq+EafeOyHiLP
	5bM3uMqPcuc8c5aHKK/GHPj0Ezy5Yy5kSrRTFUCUO6SrDUNVSR6ZHnyEmYVnaVlPU7KxNZP1rI2
	xY5Yn2fpuL/mWyZmeSftF0dRzcVd9s4UKo6zQChMpn2eEp8tXagYVUmh+/XCFL9zCCmmGfzhyQf
	/jFNWKSbQwHqh7BRQCB7Ln9G+vAX8FRE05+l7ZHPxxlPAARQbLWv21eM8vrW7stDmb1rX9obGNk
	tTGRYVjkFHwIuw0JyxTqt6ohSdTHJ5+Gtf4m4MO26pIhBbbDJ6FOB/WDSv8JfiRYtyzLpgP+cmE
	U3F/M7YlHEBwJCvG14QyT5kG1swLasuababzjpxZHKCbMa3hAAbEvDtK/RMzlq+o0/BYs1w==
X-Google-Smtp-Source: AGHT+IEC0Y6r4tWAAX1HWCsbBwXYE/aB19u5wg0kytabUISZq9YPIfqob+aeZg0wKmLtsUPhiNDWVA==
X-Received: by 2002:a5d:61c5:0:b0:3e7:17d4:38ad with SMTP id ffacd0b85a97d-3e717d43c09mr7390502f8f.55.1757419828720;
        Tue, 09 Sep 2025 05:10:28 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm234800165e9.7.2025.09.09.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:10:28 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:10:25 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/24] tracing: Add reset to trace remotes
Message-ID: <aMAZMaZJ1_Eny5Ku@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-5-vdonnefort@google.com>
 <20250908193757.079aae76@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193757.079aae76@gandalf.local.home>

On Mon, Sep 08, 2025 at 07:37:57PM -0400, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 09:13:52 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > @@ -400,7 +436,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
> >  	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
> >  			       &buffer_size_kb_fops) ||
> >  	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
> > -			       &trace_pipe_fops))
> > +			       &trace_pipe_fops) ||
> > +	    !trace_create_file("trace", 0200, remote_d, remote,
> > +			       &trace_fops))
> >  		goto err;
> >  
> >  	percpu_d = tracefs_create_dir("per_cpu", remote_d);
> > @@ -422,7 +460,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
> >  		}
> >  
> >  		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
> > -					   &trace_pipe_fops))
> > +					   &trace_pipe_fops) ||
> > +		    !trace_create_cpu_file("trace", 0200, cpu_d, remote, cpu,
> > +					   &trace_fops))
> >  			goto err;
> >  	}
> 
> I wonder if we should name the file "reset" to not be confusing to users
> when they cat the file and it doesn't produce any output.

My idea was to keep the exact same interface as the rest of the tracing. I could
keep that /trace file for compatibility and add /reset?

"cat trace" could also just returns a text like *** not supported *** ?

> 
> -- Steve

