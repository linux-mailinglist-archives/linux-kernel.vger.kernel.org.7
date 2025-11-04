Return-Path: <linux-kernel+bounces-885024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73CC31C90
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0D224FBF2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4491FC110;
	Tue,  4 Nov 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5fdgbOT"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A71E515
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268688; cv=none; b=HmyxSjY2F+WMjqHp5TxP//ynswpgUlBJwJJplfnbbbQZVsXbrfmKMkeMc+M+u48JUOTrMA+hkNnb3JW8XaZ4HUuaOxsjXWXe5zOP6oeCqf+d4s1/5N3u7MNFM8R7/wwsvydZVsbGDxHEv+Fz48xT2aSdzqlkvIQHnXnc4IwHqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268688; c=relaxed/simple;
	bh=okDzLA0rKlu/eWRDRHJjHOAGrdR4PDVDj6K4aczpkI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad32cRgX8agWulTQl/s6i2k02/rcLsD9GgFsdG1l7x2xaSQiRnjSb2L0N4xx4Rw25tWiJvh5xRVejG8wagYzmjydeqxu5loTSC5o1vY29o+TSkQblyA5U8hD1BQ7nO9KE4vF9qtzkIoyWiu/ujI4iIucu3WCdA3NnBcQrUJNDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5fdgbOT; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-940d327df21so244328739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268686; x=1762873486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=okDzLA0rKlu/eWRDRHJjHOAGrdR4PDVDj6K4aczpkI4=;
        b=B5fdgbOT85wPz82NIN2F5xgKI6pRtbJV6YD9gGrjz1wn6vuqTf79VlapwxBGVL5e3h
         8XUIvTrUr9sQDd97iHXws18BLeqyi77D1XI07qsInM05cGnLFPLEIWVghUMjOYB+fS4X
         uFmtRA6WLZ+15afkTcJ3GMWKXNFOEQuXUGSUOPEV/VOD7yoIj5zAdza2dXTxoXyVAVWz
         sVxVGU6TeZY63yUH9mspdxz+zo0vnsNv6OQ8x0FBfS1HctYbfteORvj5cyadreSKW+Az
         dxg//StdsXvNp5sNqdJ9MPclFdhNCEFUwcN/kBqQc/3p1jBqyK/5yo0rlDLS2OR9vzAC
         s2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268686; x=1762873486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okDzLA0rKlu/eWRDRHJjHOAGrdR4PDVDj6K4aczpkI4=;
        b=SvEVobQT3yYlrowOppK0/4WAjP0VVa9sN03IC980dE+53oGhAMqbBHBKH1yzlHvQeA
         0l3lCVhi0jRZGsE1lPiQwnxRdUtacaNs3kHWAnpkth9OnD2oQIQj6OSZwiXp1ZNcFq2E
         HN20JQm3LbXm00HJjlRsY68Nql61jC+BNpFPe/1gHjLhJ5VPO5vCwhuZGfdc3U8aS92r
         aLnHkMdMe3ysQTt4C1NHAjE4D7sAR56yQZLWzRFQW9n35J89ItiAqtTKKL0t1292ADrH
         mgVXQ/LVeNrLeet+p3FC+ovv4Y7ZhWqZC7JlmRnvT8MQcQytdfbg2H6iOLqGweeLcelJ
         Mdog==
X-Forwarded-Encrypted: i=1; AJvYcCWrhZPRxxUqfq+J7LRVflZbMqYbqs3E5lG5Kx3Isv3fS/xJ1Qfxxf5kOjrr/p02aB00G+NDaz184hzq3EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8A9fIBYusal4OmTGlh4fm/8j9Sy400hLm4fBajzVPxYWACFP
	L1Eg6J/bjf9UB971i5N6y5YhwNVlY46JGoXDYqu6iZLQbbFx4Z1XtBq6kTmfOApTgaeL/ws5FX1
	ZTyzrJAY/LzenFGo0InrL4PpciZ7IXcM=
X-Gm-Gg: ASbGncsYan7fBOugucN5xHIyn9YoAF2KHdCoBo8oovaJcO7QziqQB6EHHfnVBngi6Dc
	Mg7QP9Tj/ea6vWD4ZqRE5xdB75vrEgB2ZbvKmpoTMk6Twqti8Kvm98zHRmlyfup4UcGL+7IB/qo
	I/hNoik6C/G2T1gIg8gy/Bi5H3TSakTL14yGDGKb+GuOYuFvvoTkQSl8vTIYWL9GxfXXOjOSfE4
	R0ujB5fLSXZ81ItGKf83oOhDQ5862tFqwsq2WrZSGzOoOOqO+Z7OCVu
X-Google-Smtp-Source: AGHT+IFme1pTfEydzQziDdy2EyQykRR4vemY0/WnyM1b4EpMZ46mlwlGLpvZrA3qhPubS5EEjG+eX9FV6LQRljXLY8s=
X-Received: by 2002:a05:6e02:1c01:b0:433:312e:e33c with SMTP id
 e9e14a558f8ab-433312ee500mr94236005ab.1.1762268686209; Tue, 04 Nov 2025
 07:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162> <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
 <CAB95QARmr9b-jVdgDLpA4Qq=3WN7CYS46YEH4Ok4gpSdZHpq5A@mail.gmail.com>
 <20251028174541.GA1548965@ax162> <CAB95QARtzDWensRzui3d-7+jhymcFBOBi78ev9LMy=ZFJMDCTA@mail.gmail.com>
 <20251031220732.GA2254630@ax162> <CAMj1kXF2kKyEOc6KSBfbdUMf5m4o=DLZXk4++C3q-utA_9g4DA@mail.gmail.com>
 <CAB95QARrcOc6h9=YTzLKkNE0dEaivtiLfK0kEQ1jNp+v1w4yzA@mail.gmail.com> <CAMj1kXG_kPx5=3Qbn6ZTpKqOYh-mehwrH+d6Bw8QEPqvhZy1nw@mail.gmail.com>
In-Reply-To: <CAMj1kXG_kPx5=3Qbn6ZTpKqOYh-mehwrH+d6Bw8QEPqvhZy1nw@mail.gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Tue, 4 Nov 2025 16:04:33 +0100
X-Gm-Features: AWmQ_bntCa_RWqs4DOisXRX6NiLdOvI_9lZ6X800v6KH4gYTYLw5fq8z4ZSVINM
Message-ID: <CAB95QAS__YYYBLc3KFjBUg_QqC3AOB0y6kvhSqZFR9fx7BDKvg@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 22:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> Indeed. Not saying there isn't anything to fix on the kernel side, but
> narrowing it down needs to be done on the side of the loader, it
> seems.

Thanks a lot!

