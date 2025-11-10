Return-Path: <linux-kernel+bounces-892580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF73C45625
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 425D24E6A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6602EBBAA;
	Mon, 10 Nov 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0yhk6DA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C325393B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763566; cv=none; b=X76eSqCdyOjtt04DnjnGM4a4JX04iBHV/e3bSWmxWF0vNUjZsfbmdVb++1ZYIowM+KXqtCYoeumay/h6xOpFF7RGMcckSjS9bHIHPYncMQNBzgemsdv+UCfu1XhvocqaBYDNI8y/yVng2XQCTo1TEoX4py9LxiPBHJH9KEwhEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763566; c=relaxed/simple;
	bh=Kk1WJL5OvO8Dk0a049qkF4L/FOOdQuOXnHdfhx4ehaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E95T+RUz/j4JCRWEdao5YSsYKQfAvCp802LyMh20yLL1nW8qKtp957hZTVCiTVkK8j3S4ZV3oIn+i7PBzhjhcuhjrGfNmzrd8ydYGk57n7I45fvS/EWNv32MNVKW8xWtwDnESRxzQQVjDVHJE2B5FPHXmC+IkMGDguKkHdUPt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0yhk6DA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so16372305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762763563; x=1763368363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w7B3riPQ5vl5Qmlqum2iiqORAdpBKrl5g+Ab18w8+4=;
        b=G0yhk6DAW18iYT6lkjAGCM8Jc2OR9dkkJOwOrKuWVrvC24rV+7pKNpzz2qnub7DhGd
         tR9+nDZ52yjom6X/MamX1vrUHMvDg16agEhG/ErTZaMwIFfl+M61qZ+8Dr8cnXfq+mhz
         E0YfmCjQ4Kd4H0NCtK8I+BToWzwBJv0p58O/g7WRzdaxDgNK9xz6tbLMFiVrJw7zwqwP
         CudlztnjKqba1wGg15d0vwHEbsEtODa8JNeigQMSemxNmYo6MGnlTmKOXD+L6yy1Mdyi
         BsjjOce/odySiwqnSeZiLYKszAXw5HvCxmKRipRG7yGeYqwMw4tTkFBSFk2zrImj1LF4
         LpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762763563; x=1763368363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w7B3riPQ5vl5Qmlqum2iiqORAdpBKrl5g+Ab18w8+4=;
        b=oHM0zCEDQaSII4VYQB6X9T6qfTuZXiOLhFBtTX3fkJbpOnPBfK3ZnZ25xQJNwJEbZa
         VmdopSAsu4uSDvDApuJIO+HWmqLE5mqFx8fpFg4EYP7t3j2hnBZoe1Ki5KgQ+w+3RTrJ
         hWlxpVju4yLooxZ/vtaO1u58Y3ZOAhoWKpjpCWmiB2jW1bxoFXs6D+hEf01YNRlRnbHk
         rKnjBOcCCxjMSkeCqZZB0hvg98cXybLHRbvfEYPW6O9eW11xN/N2xy4c0Q2hy0iAV2Qe
         qieKXVHYEbnuvbJvrqtwOcKx2UL4OGpks9Nh5qgkq9aUGoPSM2uXHr2LBYVZtnCWuLzs
         J/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXpsi3QwcIcLWIiqQHvDzszXRnivPzIYEg6T04Fsvyx4Ez6PEbny9fvvr5CpNW+QumAcASKijG2LHTPGog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Q2ImCx/EtgB/qyReccQToEjbyyH8pEyVL0aZvvH549H7lnsw
	LBYyKADHgQVZaZBIMM/NN5Ij0KKknL8B9A+xbaVFvM3zP9Fy3XKy7Gzs5rbRcB3x
X-Gm-Gg: ASbGncuXmVFDEnuw59qHBDI83RMg9ycmaoLdE5c558e7oYVAlLStda/LNSAeGv7B+7U
	OQqbO8BZTurTDGV0Vo3M8ELlzHL8HGLfLJqOI0k6+UQxLFVuwBZpi/IrnWyf/b151ymnA8P6+cH
	2DQFl31c2g/VnUdJZWx501h5ZmfSdfL5eH24MYwh7JK7ZgjkMsq70GnkdzB+xvM52WbEAUOiL71
	VoEuhxgXh5OPOBt9CHZtwTH00Tw+isltwPSq35/eiBjQ5Jf9TbeiXIwCQkHXmoD1RxeCR6Vy2U+
	6ifupRuljzldtH8w+2w/TfWHc9a4tsFYv0GRXYlRyA/lxCYrTEkdyG0XJPeUKOqQrfL9bYpyciw
	t8QXFbITnamB/hGDugSn3sOAGaFeULCVG+HT3D35/PaAHvHOkaMxSLYRW5+V1OOE6xQpTbLFQOq
	t4+vtSajNVjpO6lg2y
X-Google-Smtp-Source: AGHT+IGhuQxvdIPqXmeyml0g9xi1//VxE7hSufLSKRdx3skhW6foVF8bcmEFQM/y9SQegjaQJUtq6w==
X-Received: by 2002:a05:600c:4ecc:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47773224fd3mr68310335e9.7.1762763562445;
        Mon, 10 Nov 2025 00:32:42 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm20385624f8f.9.2025.11.10.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:32:42 -0800 (PST)
Date: Mon, 10 Nov 2025 09:32:40 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Michail Tatas <michail.tatas@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: gpib: converted // to /**/ comments
Message-ID: <aRGjKOJmbiFYua24@egonzo>
References: <aRDo9UtYTwcoFCFm@michalis-linux>
 <2025111014-arguable-antelope-1d9b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111014-arguable-antelope-1d9b@gregkh>

On Mon, Nov 10, 2025 at 09:56:00AM +0900, Greg KH wrote:
> On Sun, Nov 09, 2025 at 09:18:13PM +0200, Michail Tatas wrote:
> > This patch converts comments from // to /**/ to make them
> > consistent across the file as suggested by the TODO file in
> > drivers/staging/gpib/todo
> > 
> > Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> 
> That todo file is a bit out of date, we now allow single-line //
> comments, so this really isn't needed, unless the maintainer wants me to
> take it?
>

No, I am fine with the // comments.
I have a patch for the TODO in the pipeline.
cheers,
-dave

> thanks,
> 
> greg k-h

