Return-Path: <linux-kernel+bounces-857769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F243DBE7E68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851135063CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A962DAFDE;
	Fri, 17 Oct 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVmy1HMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E02D661D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694819; cv=none; b=MIc8/iWb8wRwmV4cN/0rL/3M98S2kFlwb1771gcfqAhfLxZIoRZsUASFtFVlcg/+Y+k3FLDXQDyiyyISrtn993PsQlqt0zs7Sz7wcal6tKlztZWo9jwO66SdG9h2teTJ0ZZ293RqeRthg7ME8ZUlj126qqtjfI96b0Zs7D1f2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694819; c=relaxed/simple;
	bh=KrHjLjMduf6FgkomhnO5FBQ767ZzztcQTAJjtuZ1AKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HdY2/Aqkh/xs4rs/8Bg2IGHOW6enzfLOr2a+2ih6p6o1lyppPA1vSHQV8SofhdlwF6XQGNlZnN5ruAetgVom+G0q7by52AEijMW7Ugc7WfIUPTb6wkjR7EEixzZdy91sVX78LwFAFOQoygOBwv67rlPEZolZZ2wDDV7fAj2cKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVmy1HMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760694816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0DlN+TetVvDLJy3Oca2Jis/iZUW2CVvAH2lvQ+2XWd8=;
	b=VVmy1HMoipf5l+dGwumJ5OLCDt0V03W/WkD08/86iEkVd+ZdT5Wfwm+n79e/Vv56+m9RY3
	BASw0HjNQeenqCx34QWK+LJ8yyuHRhYR3CNkzIRfMwdO8DPP5szed6OOrNuR42CBAldk0f
	PL2hn/2NfVW2D9sf7VCLaoSKWJyqabA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-agIrSAI6OFa9kP6BvHnBWw-1; Fri, 17 Oct 2025 05:53:35 -0400
X-MC-Unique: agIrSAI6OFa9kP6BvHnBWw-1
X-Mimecast-MFC-AGG-ID: agIrSAI6OFa9kP6BvHnBWw_1760694814
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee888281c3so3955785f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694814; x=1761299614;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DlN+TetVvDLJy3Oca2Jis/iZUW2CVvAH2lvQ+2XWd8=;
        b=Mn9T4ssjzgEBzlCqZUPMPfwoERUcQVedVEcvVAYESZad9cjg69N5hW963f01PqdPHj
         xv13WwaYyf/ojgPa/DY7qVt9TwSeJK0iYDt9+0pVALZlaC0ky0A6W2xfe7aJoWIWyjWT
         ggIvxPM6RbiYo2XMdOf8iDD/gbqTn8+wt8UFqLNu5Kbiq7lTqS5hiITp4DbbERk4q6nY
         NzSZOrY9YezM8xUF0ogBQaDqtbqgB8a+fkx5Hct0L3tAD4Q+9JvrCG6p/J8JNzh33WcH
         kagUn9N6JMd5NnlcibSdc7P/vMo5MOrr+iOluKHkttzsZ9E8eqARUq631AdTdrL5Mi4J
         HSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhpjFZQDHJzjcuqoe54cX5c0sDK/cO0leYWRE66NUfIse1cnW/4pB+bDkdhIsJVghMCwhpuZ8co2ih5KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdffOs92gp9/eIkxQekXk34FCPlpiXDAI8krIDLc+SWS6SK17
	ESWcKccJCWTAG769IdmdPBfJCMXiNlDYnvvGcT2Q+GvFCklVgejM9oKiqTcGE1qvZqQTXxlVC90
	quaiocfuLtEmPFgW6a4sUs1t1XU3gwix9KVaBjboMbhshRRLwGjUujj6y113YTri8iw==
X-Gm-Gg: ASbGncsepv09BgnPcK3nLurSM27xytCL+hD9ZloDyhvqBzEUm1NtbIoy8+8ved7O51d
	3bQrj5YF1hQZNAHdul7oF4IHYCStxzHuzpyVPA0RKxHhDZ5tNxxVN0XusbNZhLb4KTubciOnCnH
	KVXRhKWUbMHvKHsrnRt0HrOWfrBsqew62rsu9vh253gWCmAu3hM84WnKZFNg5v54DnMnxu5Ns5V
	i+OfmXAT8hhS49fDZnm+Q5aBJ+k4xSbv/1TPj9D7GfO9ons/4rTRNUeFz5ZTTGBO5/GBdkbXVLy
	JqWDSuj7LLfPSli/9szRsEQsSbtAyqyOVsRn2cz3IyY1J0Yw1872IsgvHreIylO1ahWjaka7aeF
	jJmk7y67kVd6itTjjuzSfQMTL
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr23446915e9.27.1760694814030;
        Fri, 17 Oct 2025 02:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7402xyRnw4HcIyhbz1exHXe6Hqqxxq0TgVQu99XfFQVaLsM1t6f2xEYJ5p3QoSdq35UrlVQ==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr23446695e9.27.1760694813527;
        Fri, 17 Oct 2025 02:53:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm39455850f8f.42.2025.10.17.02.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:53:33 -0700 (PDT)
Message-ID: <352b71331769747895c86c78521975c56f27ea93.camel@redhat.com>
Subject: Re: [PATCH v2 12/20] verification/rvgen: Add support for Hybrid
 Automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 17 Oct 2025 11:53:32 +0200
In-Reply-To: <87ikgdx41h.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-13-gmonaco@redhat.com> <87ikgdx41h.fsf@yellow.woof>
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

On Fri, 2025-10-17 at 11:37 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +            if any(u in self.env_types.values() for u in ["ns", "us", =
"ms",
> > "s"]):
> > +                buff.append("#define HA_CLK_NS")
>
> That any() twisted my brain. Does the following work?
>
>     if not {"ns", "us", "ms", "s"}.isdisjoint(self.env_types.values())
>

Yeah that should do, thanks for the suggestion!

> > +        match unit:
> > +            case "us":
> > +                value *=3D 1000
> > +            case "ms":
> > +                value *=3D 1000000
> > +            case "s":
> > +                value *=3D 1000000000
>
> Use 10**9 instead, so that we don't have to count the zeroes.

Right, that's not C.. Will fix.

Thanks,
Gabriele


