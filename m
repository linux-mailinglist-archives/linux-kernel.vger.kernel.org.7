Return-Path: <linux-kernel+bounces-851753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05FBD72EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5017619A084D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C53043A4;
	Tue, 14 Oct 2025 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="MvcSFGXm"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A992749CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412294; cv=none; b=umbeLnlPcFatIQOp6fyx9lHUi9uk/jcM0FUQd49kfaZwDBHAnj4qXxtJeChM8KQo+0xi8zk6b7nwVFaEuAXId2+ET9X6hPsk+jkIOeppGe1n6a6E8eWkpfB5lDSuXL/MycWupnm9QJZYe/Ol7RDHC0AKPiV9LGVmIUATNexl6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412294; c=relaxed/simple;
	bh=wQL5zY/UYafUcd5NRW0iFch40oKFX8Y9K/L5L9dV3wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTTQPDv1F/ZIpANIlPxjCJJ8/43MfqW9jNDLZ98jR2xrFC9fvqG95Nu3xvn03IqqMhpJ0fxdYChL3l2d8BghgUqSUFzqMKBFp+mezoXHJWOWFf6zx4jNevOpWyfgoAIIxNrEPK+z77EyHxCwO0u/kcSwHenB6onubwKCojeU3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=MvcSFGXm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-85d02580a07so564767185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760412290; x=1761017090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2eESoeI7t+6CnCauxOYAditxQ8JQAouNdEK4b9YgRok=;
        b=MvcSFGXm+BO48+jNpKeI5doWWm58WD6hqHi4igrvOquX8QKZp7E+GTA+NmQw6tJMhw
         dGneZTJaXQwqyZHP1f9ygfaWaEyqLItr0eLAVqblZpUK3iw0XJnFVHYgxk4MVQrXLQtM
         T5GFlazA/LfcGhNKioy2NBM71NcP+QIr2zC7Ho6NzPdCcM53PvQRxz8g9VD4zSuAEvy3
         9PZ0A5EtFJGuK9Tgv8fqKoWr1rD76kBVO99GQpdzkAjZT80Jom6CdbxG7kA7YCCQS2vX
         +mvS9iLHMA2FjGVBumGmIOIFWz3XxXCWkjyVbKNFKsInRFJgKU6XS2zQa+/E//HI1nJQ
         ik3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412290; x=1761017090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eESoeI7t+6CnCauxOYAditxQ8JQAouNdEK4b9YgRok=;
        b=vcMoV97XAdFPALCUO0fpf8e/zSX+7De74ok7sTvMGsG5+EgRG3TbOWDIq+GmzbXbtP
         FLDUzsRO43tfchuQerv1cL7n1+cW6pAUZ9b8DWcafkg7qqh21Q/cvwoPqgfgY3fcNGSd
         YYD+Qx3I4pYH+aaprKvTPRaU9DD+dinExEX5MaYUyJyLOo0DNUE5rCD59dNjWqW8i4D3
         GfbHZ60Kd+4BFrP1w6eJDlDiAgLkT1O0kAzHH9p1Evdl9DBhmnwccwH5taC5z8p3AuCa
         4tYxj1/l2WqDCtIX+4rXLLxHh0QqB9LqZpiD2pAT0VCYZOxWTt1eWnzIuAuNGXvyp53A
         43Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWR3E2EEk2f0VNMDsAlx5HFh5+TTm8jvw2uLs1uGQ/2D1p2Uhk1I5BfmSrXnYIiOb+Q8Q5T6yMws3lAvUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsbJavczUzWTd3XEMbm8aSN/0ab8kWlZU8aVITqaMVseAg3+7
	0FjBfJvxfH7hQcaS4UutT5HAEMgVCf54kVB3n818Qek5bGoq2mVpswvCYp2nx5gGiw==
X-Gm-Gg: ASbGncs9EvexokvxXLKkaBQ5q0HGCm7eUwuDRUco4h8jgoxKyJNUUWz+SZ9YqhbiLSX
	wdYYjRKBvOJBZqX2yUlab33Bg702cFh6/mNraj6e26c3DvinbWSMLcwpddAhAe4qcCd1/fOQVPv
	WnnWQ28AVenhsUKkRweuAXOZr6ym8qqQfR78oHgqSVKz6l+XQbRk99RQK4od54ilV8o4Gmrid+3
	8ZdhRpJRhWzYJo/e4qVTiPK+dR3AHRX06NburOS4WNm3Avt2QK7KEetrfNiN1GFK75n4H+WQHKM
	zsO4G553hZBK32p+u5Y/9SQ7Dc7k+em4pcNaTuItNh7HWi9mL3/Kz+tWRRSuBkQi9fub2EKC8jP
	UUe5pWhlPbc8+rjxxn5fbmOJFaxsaWWdwix2rUfzsrF4assr6pzLFHh+PNe8=
X-Google-Smtp-Source: AGHT+IE7gll1slBbCLMRKl7QMqjWWFVjibZtwECN1/xgLx+WXONOp6Bwt8jaNLj8ynQmvDV6y6cs3Q==
X-Received: by 2002:a05:620a:1a8c:b0:851:979:8205 with SMTP id af79cd13be357-8836d742a72mr2726428885a.1.1760412290156;
        Mon, 13 Oct 2025 20:24:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::9c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369649sm1133395185a.49.2025.10.13.20.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:24:49 -0700 (PDT)
Date: Mon, 13 Oct 2025 23:24:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: core: Add tracepoints for device allocation and
 state changes
Message-ID: <3d4f625f-eecb-4265-ac86-1420d646aa14@rowland.harvard.edu>
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
 <20251013-usbcore-tracing-v1-2-b885a3121b09@google.com>
 <66a98159-b75c-41f0-8b4d-0ce9b1c8e4ec@rowland.harvard.edu>
 <CAKzKK0pzfSFJ15esnGB9gY_HMrgubZ1QtSkLOUo2FvsNGtCi6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKzKK0pzfSFJ15esnGB9gY_HMrgubZ1QtSkLOUo2FvsNGtCi6g@mail.gmail.com>

On Tue, Oct 14, 2025 at 08:05:25AM +0800, Kuen-Han Tsai wrote:
> Hi Alan,
> 
> On Mon, Oct 13, 2025 at 9:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Suggestion: Rather than printing the meaningless numerical value of
> > __entry->state, print the string value returned by
> > usb_state_string(__entry->state).
> 
> I kept it consistent with the udc_log_gadget tracepoint, which also
> uses the numerical value for the USB state.
> 
> If we change the state to a string, should we convert the speed field
> to a string using usb_speed_string()?
> 
> I lean toward keeping both as numerical values, but I am happy to
> switch both to strings if you prefer. Please let me know what you
> think is best.

I agree that if one of them uses strings then so should the other.

As for whether you should change them...  I don't care very much, since 
I haven't used tracepoints in my gadget debugging.  I was just thinking 
of what other people might like.

Greg, do you have a recommendation?

Alan Stern

