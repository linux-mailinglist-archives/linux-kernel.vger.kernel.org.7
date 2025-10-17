Return-Path: <linux-kernel+bounces-858752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73866BEBB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8ED58126F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2670C248F4E;
	Fri, 17 Oct 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnIFHLZZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC97253F1A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734117; cv=none; b=KEjriA/QYQbiPTu3/hcDbRdpDWkxSxc6NnyOW8A2T2tlB6R94Kp4U8ExL83Pi5+MR/siQ2f1GemoV1lGilpIW3Fc9Q5xyy4cAqhugY+O8SAasDgk6Of0eRdQFMEH3NKohbeMHHgZSfl8x1vPJwzMuVKt9bQcHH2N9KprbmvO/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734117; c=relaxed/simple;
	bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEv++JUYPS7pnAdpcby6pWdgmTQ1z2W/OZNPK1zyq9liVbFexGUk55PuN0ja/u0nVskUIxaYWZrO6kgbipvJMOeL08xzxtLf2eEk7530vDk8+2LMPbUz11KVcunHxryMxkngxidVBnRGZMpa1iA7owJ4Po9zw7QB8J7vBLELBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnIFHLZZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47117e75258so10857685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760734114; x=1761338914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=SnIFHLZZs7YhF2m0vcAe6oe2xSQE7X5HerxWIZHUhyYeXUfr/vpSeIuV2rCIv4Ej1Y
         ZvCk1M9UfrxvmkrBhjvhTfzrpcEjQ5i31aiY1TEDK9+gw7ES+bcHEB9K4Qv2ZL8lFwau
         w2onrMDpEfDdqPAmxo0vDNbqdxfCYANz0jtb22JO+be/pGGXtDJbiEhV/qr66XMN/Xi3
         qaVkTy6tgfAXQs1ioibH64ugtYfJtBOZPzPUTpkcUIpSrZjsL7yvUQDdeHjCTLlv+kp1
         0TghXFfBor0vE/LkNvPq1EqIl92DvkMBSS8QuROhu/tsu/pJEJFPAn4nSNSLPd9Ffx5z
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734114; x=1761338914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=r1Mh7yDuubJCB1sLphoAp+KvA51W5nrqXzLnKXuzMoaQLclKRNt9fIkyl8cqYxRFHf
         z5St4m9XzJ9vWh69S1hJIcqKwoJPY4VGEIrSX3nmUMwx3zAphos0pWctPhzrJ2iE3nI3
         hSg7+iezLWk+dJEDsaegjWTYymdp3papWudocn4PuVzsIBnrSMqVkKtXj8g/Pkalok41
         saGIgH+IEfHJgRJkyEoMK4EEAUdtNFPWWJp7a9eGKWuGeWQfkH0TsIRDKMflf+ehUx9q
         Ik6pKJSD8mVlmp7S1I1sre7U2VWX2pLT5z6oVke1MVDu3if+JOnDlI8gxWmgTEP6HCw+
         hK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCURVa5AA5YYqXjJPi5nu87XG+7kPEa4ljZqXzc7xAVSSYHD7k13YVZP0y/2r/Ee2wiqauIg0aBLI+JzFR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApCpNp1vvX3TQJLnGs102o1ayKjA+i12mEWJct8MP+hZx83z9
	AWmxgJ/vrqnQez7GOPC8cvFz105R8rk09neQZmijky939PU2iA9t7r82Kj4sCyr0ilzMdFi7Hwt
	HhQ8qJLDM39ZKP1aQ5kWkMWzuh+17Lu8b38iY2yiV2iMqjOybZE1gQw==
X-Gm-Gg: ASbGncvhqvVVLZIWFi6304q8ePxqDM5L4Wn/sSIk9zmOkLIj/GlCBg1f6j9vM70nMGb
	t7Hf2wzokGS5+rOnq7IMt/3HYBQxBx5NamRUg4qc9wx07ocFby0n6EH3Yw566zkzYwEUOHPYW4I
	IhRSA8bNpEeG6HKl9/53gSNa+Sg0B9qjvyv3m1uWXJAYTPRMvu4VvMKKcDEN6t1LvqU27RD4Xin
	9Atki0GiwnwNnb0Ox3TfmOJgTHN/uLO/7E1QFuyPycdYNRzHMPS0D0IASydGS28WGdffS4+3XdI
	ndd3mOmIX9Rz25cvsEjf7SM=
X-Google-Smtp-Source: AGHT+IHAavia4dajmjd1wu0ozenk/EgHnS13fnhiNCGOo15GBQoO3qzrk0f46KUvjIzbKPhJBuIwwZghoR1ZvbV+ZV8=
X-Received: by 2002:a05:600c:681b:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-4711792a6bemr42023365e9.37.1760734113965; Fri, 17 Oct 2025
 13:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017000051.2094101-1-jthies@google.com> <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
In-Reply-To: <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
From: Jameson Thies <jthies@google.com>
Date: Fri, 17 Oct 2025 13:48:21 -0700
X-Gm-Features: AS18NWBOVLDYxDh3NOr1aYj7ImsXftnVZMr0nHmHk5U7INnmD_I0toUf4vs0lBc
Message-ID: <CAMFSARdUMJ3WX1L8U-2k1w7kmH8Z4y7=MKKEBjCmyY-94wiBig@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
To: Kenneth Crudup <kenny@panix.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
> Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com

My mistake, I'll send up a v2 adding the appropriate CCs.

> I wonder if this is the reason my (Kubuntu 25.04, FWIW) system will
> sometimes show the battery icon as "Charging" even when it's discharging
> (or nothing is plugged into either USB-C port)?

The update to set max current to 0.1A for BC and default USB operation
landed only a couple months ago. If the battery icon issue is a recent
regression, it's definitely possible.

