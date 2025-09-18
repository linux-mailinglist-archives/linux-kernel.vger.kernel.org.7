Return-Path: <linux-kernel+bounces-823269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B2B85F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608543B5B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B790315D3A;
	Thu, 18 Sep 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BH8+S/hr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD1245006
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212478; cv=none; b=p0HvJcywOOmT+s94P+Ytch/UZhOLy2xMk+HokRZo5Z6+r+l3aj0qPVpg/L713QlpTj8mUXLNyeVz+XYmj8PaZeoTml5/UTX/P5JsUSgW3XXaBlZJ8KmoHmrZVLeUNnzT2pcHzNwccVhW1zixKcXu7fkCziO87gUOL/BmkLvoN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212478; c=relaxed/simple;
	bh=+6DWJ9V2/s86NKsZVHhjQHyxMst7QlpPf4TiS4jwR7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsPf1tysEoBfPta3sHT17JxGcf769I9oClz/byim6CajQAPwB/1zftsbnQnUzm+NJp3J7bwDnZ5GIyh1RDck7GghMxn9nBse9TN+F473UHNJHbRBTlvHK0LJnETUFfCDq1pa255fwt56iWf0/ZC+y7L7fVwYeLNeQ6xbMitNGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BH8+S/hr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0473327e70so209827366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758212474; x=1758817274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=BH8+S/hrrTxUiX3MC1S6d7HVVPrpM37Z9+StAGHka8NsJkpMwCXrt8eSS0MfQzT8R/
         gM7g6GGTaQVuYgj+J4LS+ry8uCJ/soQsR7+a6hKWV22xoHBh7NCaeirmMO02l43uuOg+
         w0icgadUhO4EZjrOqiZBAmZhbrEDWCEpgNrkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212474; x=1758817274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=Os9ewmRBMN2RMcACPreK3Be3dPpxqSzf+nel4Sxxt+Ae6H4lvJZgstV1BMPVlHoV5z
         M/261IVVJrlt447iknbcssqNXsAMRWh3EehSVAZJtmu3K2ov12bVoQiRcDOo6yFE144c
         tmw94ji6/x8dUVAd85dxcMHSw2Tkuzd8r1aUJxkNyQdiF/0+pz5rW+AgtB4t5GlTevVD
         9cOGQOKzal7h21S4L+2v+a8pytAA6Apw7h/AHLBtwGat3+v28aInwXdGU1W4GdBFt9wF
         WIgugYgD3QORFYvJ1yWr+4IAbCq6XH+Q3N8CTeR0o9DFpubIH9Lz6GI6CFMBVpRm1E5a
         /zTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCA9Gp1+1cr2AXfOS99rPRYroNFhsYYeVT4SfWK/MqdmiVhNoAhhmfn10YaB/pVqwLUhIYxsQZ5Yd6zuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRk7TizOSvhSalWAZ/HlyDlneah0PloW7x1CL1C69gAOHg0bF
	OXH8f98d0NpC4hUahGzCr1LOdsJc2x2uP6DX+l0cbxC0LPUMAAqfTNBpYc52v8SLWRQdkictRIB
	ZW+F3ehRtKg==
X-Gm-Gg: ASbGnctJp93IrmlvevFP3XR60tW2f6M4FMEJliVix7+mKl+mgrsNXZC3uXiDwwAkOuy
	zIvARfG0EYqTwj1AkpIMUDEa7tWGC/zRdGHNxw1Cz0NLJhq9cR1XKAs3pch9PUJuvh2/NmNramO
	Q65n+nHgHk9doEBQoxApXaSBBWKv/QgK0/rOU8L3Vnf0cLxGQGVgQhC0TfEIS4jWJiQUTazOrNj
	sA+QIhuhUvHC/cK0Rx+yqkJ4is+mKtS8mI8qjJswE/PuucSyJ9eH9GrFe8mSKIC22SPgQ47GtOu
	H/t5QSIy92CmnEQlix/l6+4t76cpdF/I3JEXy6pqOiQU5oSuy4JmIF9ttQhoJbf2DLObE/PRhJo
	I0rMBL+x+rIe1S2L3hFyfIiceeXgRuNZLvYYfUs4Dg90BWm0b3CRD1kyt4MHJDiN2aSu6vpbovS
	RveXf8156ccnnKr1Q=
X-Google-Smtp-Source: AGHT+IGUJNLoY8tCf8oLiYm3O4Ajw/CMlcHX6ZBr2lxYE+s00xgm9v9ghrgF4u+kFQifvRVfTRPWNA==
X-Received: by 2002:a17:907:1b24:b0:af9:29c1:1103 with SMTP id a640c23a62f3a-b1bbb15c863mr671470166b.55.1758212474132;
        Thu, 18 Sep 2025 09:21:14 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73bb5dfsm222814166b.34.2025.09.18.09.21.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:21:12 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07d4d24d09so205430366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcBLD/0mAgR19VVM4ydIatY43VoB54yQHmdFJpVkJyukaXBqCwVK+2rqsYj3NOXvAOI9SMmYqefsScShE=@vger.kernel.org
X-Received: by 2002:a17:907:6d17:b0:b07:c715:31 with SMTP id
 a640c23a62f3a-b1bbc545b7fmr610549366b.65.1758212471806; Thu, 18 Sep 2025
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918110946-mutt-send-email-mst@kernel.org> <20250918121248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918121248-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 09:20:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
X-Gm-Features: AS18NWAmxo1DLd_bNcF9s-ZOOAwZnodu5o6p8OrqHir3EF-tNoG8mT_VioNWcEI
Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com, 
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 09:14, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> OK and now Filip asked me to drop this too.
> I am really batting 100x.
> Linus pls ignore all this.
> Very sorry.

Lol, that makes it very easy for me - no need to be sorry, and thanks
for just reacting fast enough that I didn't have time to do a pull and
then have to revert later.

          Linus

