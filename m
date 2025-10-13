Return-Path: <linux-kernel+bounces-850645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B04BD35E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF6F3C5698
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0F25DCE0;
	Mon, 13 Oct 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv/aovTM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E99257828
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364861; cv=none; b=VGnxHgZ+zmPtvo6Y9RUOMagOJ5FLUZVoeyLhlIfQUwm309sxmvv6Gu4q2UzHECXHmBP2olAt42PVe/XIjIfvVZ2one59A6N5MxxsLWSR9N8e15wzdG5S3x/rsmVAHmuw/KVdeHRl1ojmP39hjP0ua9LGKxAB6VIksu4W2qfKl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364861; c=relaxed/simple;
	bh=SCBVOsr/kT8A+RaFkSlJdSvgcPvHd4n/mesfUP90fLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHB4js7HVfc2eoBDZAJ/e1sojAShmhda2nXqfNwb9g89ZWcWPCDHSV5Cm8KbAVkUhx0R4K7pMQl4KpR69/h8d8sDSXrkJxNPw3Q3nUfTVKzggi5vuoN38PXCBj8HRuPZtkaMtZKluxKU4JNfxxRrv3JWABGM8MJXcAiz7R29Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv/aovTM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760364858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=avtB/MLVqaqYb6cJjOOoguTOP3UV8Btzs9wLIrHJUWA=;
	b=bv/aovTMoX9NjMNVoFntpDSC78T6P6MN6k+vdn0dxDpMvWGhILWkrChuscg4qc6V3zuMs/
	HrzXfCX0Ox00IhNX2wB6R04tHO+LkYsF8NmuMSooK9Aj6AlCSjmsxzgTrn8ssrMxF7JEqr
	XcZ07zI56afPJN6mdNOgZsG7eLaALNY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-QBYzFM6-OEK0kKS2gSHz0Q-1; Mon, 13 Oct 2025 10:14:17 -0400
X-MC-Unique: QBYzFM6-OEK0kKS2gSHz0Q-1
X-Mimecast-MFC-AGG-ID: QBYzFM6-OEK0kKS2gSHz0Q_1760364856
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so23381915e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364856; x=1760969656;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avtB/MLVqaqYb6cJjOOoguTOP3UV8Btzs9wLIrHJUWA=;
        b=gZdE9Vin9wRHioZ7cKC/gv7a6xpemfEPOKVpP/rY6VmFtuWGdoDib9Oxi5jHVbDczt
         goyS+ZZbpwD86yu4tdJfz4wr6cPdKLI74kcPcRoEgMAFiaRDDV4enqAOuuODZajOQ0tR
         rs0aDAeSIgJgnCLrw8Bw8xQHg4v/JPDCPtkGAJE5hb0WhICNRgLc98q9Xy5brjfZOT3D
         4F691bo1Tw0Wq5x0n8kOL673Zn70r/94czWLri3Tzk7YAkUiOSdqxW1bKZFirz+SJ/Cn
         Ef7YaIpRvzc2rn86wuOYef29GNX8WL2/aR7zXgCHqMoZtK8Re+yB0M/t7TYpYafWrqVP
         BPxA==
X-Forwarded-Encrypted: i=1; AJvYcCVheYVcWl6OXofW54LJzX5bFP0rbwdyLHHEoUF8y20NdQqReoqKqij/8o4949R+umA7P/VlX3gys5Brqa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4jqjy3GpoNLhga/EhS1uyjTXwyUOokgi4tSwyM/F9+uRPot8
	ToIfpShFOQvtmiuWEa7YH1CWscvA4FWfGczUAJqHO+iE2ZoUODZ9WIBDu9sjsZbbM84qWdGWCIg
	l9LsTDXrPUTRGbe3r1uaObp7U+w02S517zhrUOwFWRKi6eHGnx1y0gY23M4VQuIi3Qw==
X-Gm-Gg: ASbGncv8aTXAthCXLL4My9hK+wwzShoYktAXQYpE+VQKgdJU6rHHs+Ylv1ekrNgR4sf
	H7iwkncMK3Evkk0af1JceYnPRuP5zMlJhcAJx8X38kGC3FR0QWJWCRc3WijtxT8eKYmCm30yfJG
	8YX6doBd6N4MAgrvjPWXf60vRg0zJD/hWs4DtOk2UZlt/GRS6Or0gT1Kd90hcZtyJ4zdnzXKxtF
	KIJRIdomHgHfukM9o7mEwuVuOUUmIQ7MeYaBU/hc71wfiWTuk4PfFYk9MCPTEay+MAucJlRVfmH
	nWtCGz8+Zms4mTY7MGolz68XgN19i8IxNud1WuUzSMKT0+lFp9EcKAmfK+HofmoSQA==
X-Received: by 2002:a05:600c:628e:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46fa9aa2123mr128366565e9.10.1760364856211;
        Mon, 13 Oct 2025 07:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHETg7OzrKPGssdxOk4Xay7k9qUcbXQBRsqtLsD0xpqB63fcoVeQyDZ4FRhiiS3UOs6njcyA==
X-Received: by 2002:a05:600c:628e:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46fa9aa2123mr128366395e9.10.1760364855797;
        Mon, 13 Oct 2025 07:14:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2d65sm126639365e9.2.2025.10.13.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:15 -0700 (PDT)
Message-ID: <db32cd9db7168a28e6d16d16b3bbe905a6c2c9f9.camel@redhat.com>
Subject: Re: [PATCH v2 15/20] rv: Convert the opid monitor to a hybrid
 automaton
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 13 Oct 2025 16:14:13 +0200
In-Reply-To: <87cy6uygn9.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-16-gmonaco@redhat.com> <87cy6uygn9.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 16:29 +0200, Nam Cao wrote:
> > +		 * If CONFIG_PREEMPTION is enabled, then the tracepoint
> > itself disables
> > +		 * preemption (adding one to the preempt_count). Since we
> > are
> > +		 * interested in the preempt_count at the time the
> > tracepoint was
> > +		 * hit, we consider 1 as still enabled.
> > +		 */
> > +		if (IS_ENABLED(CONFIG_PREEMPTION))
> > +			return (preempt_count() & PREEMPT_MASK) > 1;
>=20
> FYI, there is plan to keep preemption enabled during tracepoint
> handling. So keep that in mind when this monitor breaks.

Right, I've heard of it, thanks for the heads up. I'll adapt the monitors o=
nce
that happens.

Thanks,
Gabriele


