Return-Path: <linux-kernel+bounces-738688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA7B0BBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D71B189639B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21420C494;
	Mon, 21 Jul 2025 04:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJa5D1BY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBD1A5B92
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753073954; cv=none; b=OGYOOj6NvrWaS1XPflPilR9+aTTtz1k13OlSmnDSlNCyBX4YakRK7g1elcwUGK8UG2Z9SBEYpIVL6Bq0+ghRPNQYRAym9Rf4ZirejHAYMzK4BogjyrFFJqwQapq/lPEAzY6abtMj2mrlPCGCqUor0a+Xuaz8UMiQuccYpM/Jvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753073954; c=relaxed/simple;
	bh=mvWB4P/E9pE03LkxYqjveBOwnQyOOzLvup+2IjSffD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qk+MvRIXKrGEhYymnydMHXZaEwEKjm6mf/gCuGI4TKTdLpPLI0v/55kohIfGlkUIakVM2i66iGW0XiW8BrdfSserH6I0ZkXYVYYZ0fEy8hFBRsbEeLitXxZLrDUeqpKqi6UsrFFu24yCZ1XIeR5wGl3lMCs1KaaHsoFoWA/uxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJa5D1BY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753073951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bH6FIOA1hXmC9sisAgKtf3lBW/YyUX04yADCCnU0o1E=;
	b=KJa5D1BYm1H8g02FHG4ulCOcsuD/UgfCSiSrYFujKbIhaQ8kNwQC2LDsfnektcAygveEEX
	EyCf7UZxutI+0I1FyqN/ft9r7PDfNvtIjllObq8ur7NAE3ofFmh4xaASTrdvyeKufUbMuy
	R3KxUM8JKAyzUMJNkll7fWtQB5ll9kE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-wowqEN8OM-q8cNEMT1RXmA-1; Mon, 21 Jul 2025 00:59:09 -0400
X-MC-Unique: wowqEN8OM-q8cNEMT1RXmA-1
X-Mimecast-MFC-AGG-ID: wowqEN8OM-q8cNEMT1RXmA_1753073948
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31ff607527so2822165a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 21:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753073947; x=1753678747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bH6FIOA1hXmC9sisAgKtf3lBW/YyUX04yADCCnU0o1E=;
        b=ss5UFo3s94zEAYFepznO9mvyXQz6s6ko5Isk6GwYtp9xx4rvJ1w7Gby53MWRuV2uP7
         cm2ItXT+8sMaZtu8M4YpFD7TbNRI6ikoQj47DkwsZFnqmnxsKXQEIpA2YSbumSjD8nP5
         tYzVWpnjqTC4ApMC2DsuxhlbuSe/OgkoGKNZOAA//ArMHZfcEHsS9Tvb4rMOWSC0R5Sy
         32rIBEtTXT23I9cm/eLP/Tk5VUuDt8tmyxo4AasFhhmEgC0HqigGKaGETatyil17k2Rm
         aJHHlPQPedKY+oQah1UD96sqV1aJBI1WztsnC0F/Tyf9FgjPK6xXKISscWKS5SiM+euC
         nf4g==
X-Forwarded-Encrypted: i=1; AJvYcCWJsfP0NN7LKE0erfdI8SZ6lgh9AsUPADmDgkpEBbuqbOlC3PirlINAGNZfgoNA1cp+y3g/85a3/CSxvWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPGdQypzv0m52/lCvFGxZZ5fv4jNr+J1GCrSO9Q1WfjGfAdxY
	XrjZWnHhLHipG6e2+NzwJjKTVqZ1LM4U5gBmh0WoNVtdrq9RGcV44/XeC96eK0U/4BmJFqZob0f
	SpPldajea7iNGGADPFGBRpjfxJNUdfDDcvLH7xhKTgy9WOxFrePE8+vMIHA5RDypPeM+G4VjRSw
	==
X-Gm-Gg: ASbGncuee7Z3yWLcjiRUIchGCZ0hfRzLKEmo9+Sh956DE4irQcqDci3GluolBGa0C3T
	v1F+zlnnruxTXgcHrVH6xlei/Uc7/xc31Zmtwrd5E7xVc/2BjefXHlEgnOJS9i9eMLjY40OEcFz
	jJ5Z2VSvIPy7ssv0aTVjr8yHEBluKtNWkcQAKfaiH7im4ADO8LNRfv++lYEJdoyACikr7t8Zox3
	J0Pd57O4Z6oJWr3i1PbhpBKHOZA5w+0r2uji+oYHczfWTDu8I4B47A9AdkwU+yjnLC8XN8A5BFl
	QJ0dx2iP4VD7WRjiDX/T7Mo2o0gk6hbEOvGiQ/HwtOfpLcBBo7tR5yHezSSaGM5LwF+Gk2CokoT
	20ws=
X-Received: by 2002:a05:6a20:12cb:b0:234:ea1f:9744 with SMTP id adf61e73a8af0-23812a5a391mr30346263637.21.1753073947179;
        Sun, 20 Jul 2025 21:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzznGewJQ6PhBVGeM6KRtxlsQQNUqEypvmnEpjI5fcazUC+gWUZB6zWNU/duqeGf9BIERdw==
X-Received: by 2002:a05:6a20:12cb:b0:234:ea1f:9744 with SMTP id adf61e73a8af0-23812a5a391mr30346245637.21.1753073946755;
        Sun, 20 Jul 2025 21:59:06 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff89341sm4429837a12.52.2025.07.20.21.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 21:59:06 -0700 (PDT)
Message-ID: <b6c5ea13-1d7e-48f2-a1c4-e24d0ba30a63@redhat.com>
Date: Mon, 21 Jul 2025 14:59:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH MPAM 6.16.rc1] arm_mpam: Enforce to recalculate mbw_min on
 configuration
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc: sdonthineni@nvidia.com, rohit.mathew@arm.com,
 carl@os.amperecomputing.com, shan.gavin@gmail.com, Koba Ko <kobak@nvidia.com>
References: <20250626095208.1008871-1-gshan@redhat.com>
 <0f2993ff-75a1-4d63-9384-5c949bf2e8e0@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <0f2993ff-75a1-4d63-9384-5c949bf2e8e0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/14/25 8:15 PM, James Morse wrote:
> On 26/06/2025 10:52, Gavin Shan wrote:
>> mpam_feat_mbw_max is exposed to user by resctrlfs, but mpam_feat_mbw_min
>> should be recalculated based on the maximal memory bandwidth in every
>> configuration, which has been missed unfortunately. When a new group is
>> created, the default and maximal memory bandwidth percentage (100%) is
>> configured, the configuration instance (struct mpam_config) on the stack
>> is updated, including the minimal and maximal memory bandwidth. It's
>> copied to the domain's configuration instance. On next time when user
>> tries to configure by writing 'schemata', the minimal memory bandwidth
>> isn't never recalculated because mpam_feat_mbw_min has been seen in the
>> configuration, which inherits from the domain's instance.
>>
>> For example, the value of register MPAMCFG_MBW_MIN is never changed no
>> matter what configuration is set.
> 
> Thanks for catching this. I think this was introduced by the patch that picked
> the component copy of the configuration, modified it - and passed it back into
> the driver. That had the additional side effect of changes going missing as the
> mpam_update_config() had the same config twice...
> 
> I fixed that shortly after rc1, with that fixed I don't think this can happen -
> resctrl never sets the 'min', meaning mpam_extent_config() will always regenerate
> the value.
> 
> This shouldn't happen with the latest version of the tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.16-rc4
> 

The issue still exists in v6.16-rc4 and v6.16-rc5. Here are the dumped registers
on the varied MBW configurations, and MPAMCFG_MBW_MIN doesn't alter.

   # uname -r
   6.16.0-rc5-gavin
   # mount -tresctrl none /sys/fs/resctrl
   # mkdir -p /sys/fs/resctrl/all
   # mkdir -p /sys/fs/resctrl/test
   # cd /sys/fs/resctrl/test

   # echo "MB:1=100" > schemata
   # cat /proc/dump
   MPAMCFG_PART_SEL            00000002
   MAPMF_MBW_IDR               00000c07
   MPAMCFG_MBW_MAX             0000ffff
   MPAMCFG_MBW_MIN             0000f000

   # echo "MB:1=2" > schemata
   # cat /proc/dump
   MPAMCFG_PART_SEL            00000002
   MAPMF_MBW_IDR               00000c07
   MPAMCFG_MBW_MAX             000005ff
   MPAMCFG_MBW_MIN             0000f000

The problem is mpam_feat_mbw_min is always set in 'struct mpam_config'. With this,
cfg->mbw_min won't be recalculated. I guess we probably just need to simply drop
the check to that cfg->mbw_min can be recalculated every time? Could you please
fix it up in place if the resolution looks good to you, I also can post (v2) to
include the changes if you prefer. I don't know how it can be handled since the
code isn't merged to upstream yet.

static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg)
{
	:
         /* The mpam_feat_mbw_min needs to be dropped */
	if (mpam_has_feature(mpam_feat_mbw_max, cfg) &&
             !mpam_has_feature(mpam_feat_mbw_min, cfg)) {
                 delta = ((5 * MPAMCFG_MBW_MAX_MAX) / 100) - 1;
                 if (cfg->mbw_max > delta)
                         min = cfg->mbw_max - delta;
                 else
                         min = 0;

                 cfg->mbw_min = max(min, min_hw_granule);
                 mpam_set_feature(mpam_feat_mbw_min, cfg);
         }

         if (mpam_has_quirk(T241_FORCE_MBW_MIN_TO_ONE, class) &&
             cfg->mbw_min <= min_hw_granule) {
                 cfg->mbw_min = min_hw_granule + 1;
                 mpam_set_feature(mpam_feat_mbw_min, cfg);
         }
}

> 
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
> b/drivers/platform/arm64/mpam/mpam_devices.c
>> index df8730491de2..4845dcb8e601 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -3192,6 +3192,9 @@ static void mpam_extend_config(struct mpam_class *class, struct
> mpam_config *cfg
>>   	u16 min, min_hw_granule, delta;
>>   	u16 max_hw_value, res0_bits;
>>
>> +	if (!mpam_has_feature(mpam_feat_mbw_max, cfg))
>> +		return;
> 
> N.B. - The T421 quirk needs to ensure the minimum value is never set to 0 - which is what
> mpam_reprogram_ris_partid() will do if there is no minimum config set.
> 
> The aim of the quirk is that on affected platforms the mbm_min will always be set, and
> never be zero in any configuration. Whether it then gets applied to the hardware depends
> on whether the hardware has the feature.
> This makes it simpler to think about - and easier to test on platforms that aren't
> affected by the errata.
> 
> I'd prefer not to to try and spot configurations where its going to matter as it will be
> hard to debug the workaround going wrong!
> 

Ok, thanks for the explanation. In that case, we shouldn't bail early. The mpam_feat_mbw_min
check in mpam_extend_config() needs to be dropped, as explained above.

> 
>> @@ -3211,23 +3214,17 @@ static void mpam_extend_config(struct mpam_class *class, struct
> mpam_config *cfg
>>   	 *
>>   	 * Resctrl can only configure the MAX.
>>   	 */
>> -	if (mpam_has_feature(mpam_feat_mbw_max, cfg) &&
>> -	    !mpam_has_feature(mpam_feat_mbw_min, cfg)) {
>> -		delta = ((5 * MPAMCFG_MBW_MAX_MAX) / 100) - 1;
>> -		if (cfg->mbw_max > delta)
>> -			min = cfg->mbw_max - delta;
>> -		else
>> -			min = 0;
>> +	delta = ((5 * MPAMCFG_MBW_MAX_MAX) / 100) - 1;
>> +	if (cfg->mbw_max > delta)
>> +		min = cfg->mbw_max - delta;
>> +	else
>> +		min = 0;
>>
>> -		cfg->mbw_min = max(min, min_hw_granule);
>> -		mpam_set_feature(mpam_feat_mbw_min, cfg);
>> -	}
>> +	cfg->mbw_min = max(min, min_hw_granule);
> 
> While resctrl doesn't use it - the idea is the mpam_devices interface should support any
> mpam control being set. This overwrites what the user asked for.
> 
> The devices/resctrl split might look strange - but its so the resctrl ABI implications are
> contained to one file, and another user of the mpam_devices interface can be added later.
> (KVM in-kernel MSC emulation was one proposal, another came from people who believe they
>   need to change the hardware policy more frequently than they can with a syscall ... I
>   don't like either of these!)
> 

hmm, it's intresting to know we can't tolerate the time consumed to finish a syscall.
The MPAM would have static configurations, meaning it's static after the configuration
is given. Could you share who is looking into MPAM virtualization? Actually, David
and I also looked into MPAM virtualization support, but we had everything emulated in
QEMU in the draft design.

Thanks,
Gavin

> 
> Thanks,
> 
> James
> 


