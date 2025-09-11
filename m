Return-Path: <linux-kernel+bounces-812414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC49B537DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7785AA13D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CDF343D8C;
	Thu, 11 Sep 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GF0dUx4/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDA17A306
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604800; cv=none; b=aWlOsq90RfeX2wxAdE54KmiPxC5qEE0+kdM5JWGogp1wwoL1Ne3W4xZTukhmKrZOnUH4myBRq2dg31LNs9xzSwb28DEpURae7mp5502KsE9d87iNRsFDrq4aOgxHSRK1VynRlKbNkupMsYLm9fEFvxsP8dLm5PAf6HNKQDtqMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604800; c=relaxed/simple;
	bh=F0fjuj8PyX9fcZldQwWiTVVE7c28IvifQRkVsNUVQR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AANXxCaEhAqPeD7p0goCPUzqIIxuFxbo8xmQw1yKip4tkXSYK7H/T4JOAcFSqPDKMZKlNSFuRQumRBnpbOMLwmEgxh50OvpYClRupVnv/wgVQd+iiiV8tXuOQKXn+CTAwEuPmTnNzOm1CYVlbbVwya+2rAXu5fXCVEbr/Miz3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GF0dUx4/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so1081271a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757604796; x=1758209596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqRFZ+cva9fquQvm0m4drIXyert99xr3JeDs3bWzkkI=;
        b=GF0dUx4/drhiyrl0V5DD0KrmeQBWAPBmsG0XydtY0GpqDVHV0C+0pCgBZGcEIYaVTS
         smyDsLDWhcyQt0xaN4muOAcrS97v6sJXiEUvfAPB/twqI7MR25vGLIP7Ww5wphmNW79O
         md6Js7FjAU5I/HquvX11bA2ryEg5XtPKmMtRcdmzYeb6XY8Xrnz9aw0y0Wx3nOYsxvh0
         zkThYGLIeqbME2HQMNfP7Sfk/NUYMLgMVuJiXLDdi2yfUBJfhY6ooeWJWu/ySPrr8CbY
         LroHd0VI2bnsoupbADSuQa+KEIIV2kafQV0zm48P25KrwXwhAaCI4+AfRXm48N8/rSjq
         wqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604796; x=1758209596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqRFZ+cva9fquQvm0m4drIXyert99xr3JeDs3bWzkkI=;
        b=ZMV7VV/sE4gqK8btnipd6gdet5bgqODYJMb2EGtbtT3x4Dh+MDVZ3y2pUmJrPrvPbk
         nZ3AycQs/KeeLzo9UQp0tpYyEPPy7CbvMAhl/r99BPvo+7kWK3Xe4anTBf2pMqWMdvYH
         YuUTXHG+C8KbfAEg8nKKBqO8jT2EsrOsxDEFchGjdjJ2uE4NtpLFzYaKDH7VpHsTaIOg
         XmWJ+vbDCV6Trc2MucJty7llKYPSOZYo3nZ3Idsd/wPbYww4ZLVj54MdukDQneGTPrls
         1Nx7Z4DJtI2mvUDq9uEy/Ob/d6mwai1W4m9x0kGLjcXolbV4Z1wRWWL1uE4wQXd/7TE0
         l4IA==
X-Forwarded-Encrypted: i=1; AJvYcCX2/B8KJr/l916+g2HG5cugs/CvJAbSMh1PLSyztCFsD/tUyEaoPaiYhMwqKTzPB8Drh56UGZxNX/a0MMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGczGTgnObCzcKxfHxQN3sfbGXlC85FXBdTuHIfWxs06x5Psc
	K0MNI/7MFlYQaUsZ+kZCclEBqlAOzFeOUX0+Yxq5d7nwcyy3y4wXEWix2oTMsZEclK8=
X-Gm-Gg: ASbGnct4HWB7D/TaoCZBFwyz0ZVQF6mpZF/lSre/4JvxZuPq/QOw1oyNu//K/fRY6Er
	fp9c26hXY3QojcMIh3vNfaDYRa1H5UzXsaTXRgqX6iGGTa5kIGOasaz/Vwz0fdqaGTW7JoB0Fcg
	/8svHihpq/MaDOBhfT7j/xl2ldOr9IeIIioLUC5RCyuqk+o2MfqbCFWXjor4f8XpHikncpR+dSF
	YndMo+rssVWjXXG3KjGy3PHn8lms9aF3xVR1sWYfXDCnHcEP89dWoBSCsu5E5Pu2OgJZRgvE87U
	SGkyPRjuZtwFKG3iSXUlrx+2x1P+2ydtNkDKQqQZsYfoVRAtQ9VLtz7sAIDExM42H/8tuHcg0D5
	kPuNWVnlLTdiIPfg3y4Uh3HOFnFXgKQFMFkr88B4eCRWwy7w=
X-Google-Smtp-Source: AGHT+IE819B9iXRZbQZWyTFSBy6SGNkKVKmlpMwEdJVw1XOsVU+v0KCsVT9kJyQb8+d04XBuqlPZRA==
X-Received: by 2002:a05:6402:44d2:b0:61b:ff85:398b with SMTP id 4fb4d7f45d1cf-62ed80ee786mr11858a12.14.1757604796306;
        Thu, 11 Sep 2025 08:33:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad6ebsm1340574a12.19.2025.09.11.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:33:16 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:33:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMLrulj3_qG_y3RP@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
 <84tt1gex89.fsf@jogness.linutronix.de>
 <ea3b4933-49d0-4940-9f05-d8e2189606c8@yandex-team.ru>
 <84ikhwev7o.fsf@jogness.linutronix.de>
 <d4d676a4-643d-47fb-974e-fa08009ce23b@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d676a4-643d-47fb-974e-fa08009ce23b@yandex-team.ru>

On Thu 2025-09-11 11:34:54, Daniil Tatianin wrote:
> 
> On 9/5/25 7:10 PM, John Ogness wrote:
> > On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> > > On 9/5/25 6:27 PM, John Ogness wrote:
> > > > On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> > > > > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > > > > index d9fb053cff67..99989a9ce4b4 100644
> > > > > --- a/kernel/printk/printk_ringbuffer.c
> > > > > +++ b/kernel/printk/printk_ringbuffer.c
> > > > > @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
> > > > >    	}
> > > > >    	/* Regular data block: @begin less than @next and in same wrap. */
> > > > > -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
> > > > > +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
> > > > >    	    blk_lpos->begin < blk_lpos->next) {
> > > > >    		db = to_block(data_ring, blk_lpos->begin);
> > > > >    		*data_size = blk_lpos->next - blk_lpos->begin;
> > > > >    	/* Wrapping data block: @begin is one wrap behind @next. */
> > > > > -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
> > > > > -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> > > > > +	} else if (!is_blk_wrapped(data_ring,
> > > > > +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
> > > > It would look nicer if the arguments of the function were indented to
> > > > the function parenthesis:
> > > > 
> > > > 	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
> > > > 				   DATA_SIZE(data_ring), blk_lpos->next)) {
> > > Would you like me to resend with this addressed?
> > Knowing Petr, I would say "yes". :-)
> > 
> > But wait for Petr's response before sending anything.
> 
> Friendly ping for Petr :)

I am sorry for the delay. I actually was going to look at it today.
But to make expectations. I am a bit overloaded by other tasks.
And frankly, this patchset is not a big priority. It allows
to use 4 unused bytes which is a negligible win. And it stretches
the limits which might open a hole which was closed by chance before.

Best Regards,
Petr

