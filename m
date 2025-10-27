Return-Path: <linux-kernel+bounces-872398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D3C10B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF851892DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F23233F5;
	Mon, 27 Oct 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVSwdn4J"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C58329C7B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592136; cv=none; b=Nfit1T2WCs1XTzlq6HWVtR8EWr7sK8fHYEG7DrNH1z+WtbIJJpII0DKLfF/diU+19JtFElTiPdKDyQ2hSZAN++FeDyelEQUdWoXAaf9EKfzkJqnqxRTqwD4dn5OqvrYB2pFk3EbsVEBGYM8Uwkt+aSX3Hra33RbUYqfuboUd4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592136; c=relaxed/simple;
	bh=LwAmk/7MTnIWI2oZ7HDPyu3lp0S1pBrNDG9x+kH9r9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1IR0KqGPMLIbLJSLVE1dJIMqqc/LE2aI64575PrLYFV/56GvD/Uk1A3o1cJ0uLmagzyhfjw96SdXPfOb7gxtlid1r5t265ezdxl38hcTe8DKDFhfyFguyTvX6gXWMdDygy+q7AdD6Cd/Te49geXSJJ2AnJFLkmyot0ccgX+DNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVSwdn4J; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63cf0df1abbso5698754d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761592132; x=1762196932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=hVSwdn4JOcoqaHNLFfLQxTu7eWx01Rgqd59pBAURulTcRJlYT9XZil8D64vaoIKaOU
         gfhxXps4MOYzdEvxMaV1knXwOsJHCSSn408048iYjmlqbWP/0AcrxiPSiyjj1Ssa8OPP
         p7Lio09UtU4OeVO4jyJOTDKLcTpqHqFVjBhsUNQ0nesJO4M46fw4zBeXMfl5M8TyZhOg
         E0/Zy38JkAphtr6W7H6oRnKX5ujQ/DAJqP9JlL8+Fmhd5ptzzNnOOqmaIhKJqyuKwyWy
         9X146AywMJ0HzBTfXY5bZettFAhXL5zRIs/afSJUQRFwHucVtfLCnF7+aGlI4DkFiRGW
         XE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592132; x=1762196932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=XlIiKV2VYufWH8743gjxwME784BHtXJ4Kmxdej5/kwlOnfmjd3//hMvrMdI3VDeHWy
         hqZ3KVSdDCXK3F3PPkmeTHLKOfZ8yySWFc6zCooTLyA/qUVMFAxLzv+LOqHvO2IFJsiY
         ZFFGwjpmGli3+wCdvdh53TO4+DaKGCups+XmioOto/bA+aMJqmxMXgYKQUHCS+cwc5kH
         cmqP8/zlx3VZxpFlfc5d11mUXFtPJbHfaclp8nGPtHvieypMO5P79/cHI0EGOnT8Ct8T
         yH6eiAtsmK9axDfqBtMhvuKDp59H5/BcKJ4zPA2ZbKM+TEFxKXifqqKfSMsTnx565EbE
         xSxA==
X-Forwarded-Encrypted: i=1; AJvYcCW8/98PRmAzFlBbesLI4ZOe9VWlm7KA5a3HbhMdXjgZIw/cNv6bcItPVsRZQ7wBbvOoGr6prZxLjwOhxKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yyWxNcNPJWdB/tXRddcRhS6LhmNDWiWTEhypR5bKmO2QCJeC
	M7D87e9yeyg9/V2IEKvxVcep2BwWU6vOt20MxA4xXrK7ZVmI4keQc1Rk
X-Gm-Gg: ASbGncuXEH5KrdXBoDgZkFoRGk82oS+/eE74HJNkozX3OUhKV5m/uE1K3qgPMvlS2ep
	Vs7/7oyNlW7xlM9ZAqZkBV5VnxfROt6eCk7XA+i5v81eDZhari2jVzON7x+DFumfSjH17tBMe4u
	c4EWCxqOrUigjc6kVeXxdj0JsIdAqPOMmMknHfeVNy8WzmISOohN4O2ek3yE8YUGA5LuAA5iEV8
	XHATaZd96f2yUeM2pC/uo1tkqYogY6MqeoZ+Qyv76PAm570NwB+Is1MsPXXvbUP+4Poi5QrLX9K
	yWewk4pV8EIlttWjV295MY6mVfPRJ0Zgahj5L5tQMncqybGg5hhE0wgJU6UB5T/ZtWAkpXa6ugR
	p1dZCrja2ugxhF4Sn4IeuDkyUGBZ1PThJp+zCz9kRyAsd3N5VtgrwQ5gOWPPLxkjVTpBN4YzpKW
	0elBtKjwsRJgYcSoBCeOC9vgl3gThGuun7cFRKwK0e+aotiyw=
X-Google-Smtp-Source: AGHT+IGyyVhNMyFPJ1iH6VB3LobfrBQTkhvZ12vnfHgjuauZlHjFnodUEDbnz8J1VMMlZEjH/eQK1A==
X-Received: by 2002:a53:cd41:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-63f6bab5662mr707347d50.65.1761592130958;
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c441fe2sm2525648d50.15.2025.10.27.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:08:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > such as waiting for the server to reach listening state and
> > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > from hiding failures.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > shellcheck has some (new) things to say about this patch too.
> > Could you take a look over them?
> > 
> > ...
> 

It looks like the errors are SC2317 and SC2119, but are false-positives.
Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
being passed zero arguments (logging its stdin instead).

I also see that SC2317 has many other false positives elsewhere in the
file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
unreachable. I wonder if we should add a patch to this series to disable
this check at the file-level?

Best,
Bobby

