Return-Path: <linux-kernel+bounces-859679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A43BEE42C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AA0402734
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E12E2EEF;
	Sun, 19 Oct 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCwmP/RT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626C22A1D5
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875055; cv=none; b=AV57shuAuFQ+P2x+YQT+/PoH/ihtt9ZbAdJaytr/jzMsSV6kcgZf6n5Vpj1ncGXVgJGeOZpKCzXsp3Tw3h+qV3J6UmFs8r3xMm48v3p+DGIY66NXKRum7ztr7sGjSo3HYHfRlXEM/ZlAa8b9Ko8gUYQE87yJBpMizqceqtZ9/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875055; c=relaxed/simple;
	bh=2EmecCtEqlb5wSaa9tOcwvaTQd0L0dQSZIOSVmA+sik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzGfBMs9G+F66dQK4lJev3t3bgCDrh0/FiJJh/6dFJkloGSxUyoMhDsDza4cJmbVDxSk4mGA/bsU+leESunEMt79gAOlz0+RKQuVBhBy/yKBeh1UdQyJp4RqC8KgEP79mh//uCs2ygtbOoki+L6VeAP2jiY2yaRqvUAlWxcATRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCwmP/RT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so18672805e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760875051; x=1761479851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFyJz4TGbBiB8xKgL30elmXo6maKrPja2K5Egv8H5yA=;
        b=eCwmP/RTxmbK5jTPhUyTZLoVPT12MTQtcil2PhfY5omyZeILbBAk430E1z4k9Zgm1y
         r5hz68ydGohDlliRfQs8gFQs/zbUojLnU+TeeoBxWIuG+xq7fEbhGfCIKRNq4z/0hivX
         x0UtVIa0CFvH/rEXmmoChKvyMcx4vaZi95Xx+SYB2YO6Hw63nZABNy84LP7HFpki34qQ
         4i7ASjHyWQPz6aw5rE4u8ySFqALwFcQM6cjHfZQpllktg3DUiJicPPyCsRarIoxk9j+h
         LgfE86iQdxcKbCBkqm622sKo2WWdwR4rVS/4PngkE9OwXsG9ndepORfvuPvV51GbPZ7i
         BAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875051; x=1761479851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFyJz4TGbBiB8xKgL30elmXo6maKrPja2K5Egv8H5yA=;
        b=MaKlmntAILNrSnMOlIcUbVMEH7rTf5Jcq4G7jXmJFhQ9sYHKAz8zPJCKJ5r8k8Oo2a
         C79B3xA5O7m+GKTMpxuonQ2VpIJWxcZApKRsOB6QDFKbpyhMf7BvtdvVZDmlZ6RfcQjK
         8fHJ9pX4xAj4pbHg1EO5+irNl3eHYt7K7aYtdsUhJxkbhbv/yN6vokoQtjdfhiY8S5Pu
         vGndRgd9krpl50j5mGg97Sq7d0o06w2SAMXDETSiUkQNavysbs3XW1/8FT9CzRZaLuEL
         Xiyl+yeXmy7o16oncpxbK0nAswnHblv/1cDB1jK4NT+lPkbimKUYnbTlw3cNnoYgeXl3
         OgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0p/8fpNrxGGxDO7KM2DLQblW3gjXFTgIEfIr5KDgwa8OF1Zw8kIZWXzqultnixz8GMusIWXKU1nDsW5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDv4AgyfcDZBs+LX0MU5uDciDQcwL71lTB6aqvMFdbmVp6CIG
	oFbvX06OgibJhkch4uxsTjpyzUZidmRCFy+lHGMtUvy75Bn5WCIgn/o+
X-Gm-Gg: ASbGncsSo9ACX/wDa9BCji5LITJ9LTEaRbSQhob1z4AVj9zaktlJSwdXuh9Xcxr8lq6
	QRpgQ+pb7onnVt6xI9ZxvvGEWrAWfWaL70BFtiS5rZb5FmuqST/ixMeTAVUgo4I11x1Cg6xMNZw
	LAMk/cBEMlRCdTIvUdV7CskhlrDRQQZZ5vjnLJPMPoYkvulAFYfSzpVobajdyx8ddPVATGJfxYo
	cSiBsTKhNAp6M1Zw7hsvbcBsr6wYPkgAkRZK4wkl9ftal5Z/8TbnXd/oTa0ArYF726laGO6XR/i
	7vnY9yDfbLoeXgbdmqy17QMV/G2A0Qheg4ecWZLiqDswFkgaXejKR3AhG3IUYq+YMfvFEQbWqZE
	KxPFNjsbllGxQdt4lhYLspNx4YRtk24FP25O10ueMR5tc5uB0UK8yZNJru4sATM3ZRephHW0QBD
	9P0vE1zkLlZ1ou74IxVPBtKWat+lZym2FU6e1rHdzurH8n5aUGV2Be2qpD38l9fwN9ass=
X-Google-Smtp-Source: AGHT+IHvDD+ifAg+17oqux4wEgOfVHaOlLPFxtbGdrBBFjTGnfI9PU8wWphxIaLJLYGzyWFboM6Djg==
X-Received: by 2002:a05:600c:548a:b0:471:669:e95d with SMTP id 5b1f17b1804b1-4711787dcc8mr62020415e9.12.1760875051305;
        Sun, 19 Oct 2025 04:57:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471529598c9sm91035475e9.5.2025.10.19.04.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 04:57:30 -0700 (PDT)
Message-ID: <72cfbe83-e587-441e-abfb-b50155a326ab@gmail.com>
Date: Sun, 19 Oct 2025 13:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nova-core: Solve mentions of `CoherentAllocation`
 improvements [COHA]
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
References: <20251015194936.121586-1-delcastillodelarosadaniel@gmail.com>
 <DDK7N52VX059.202D7SPGFV8A9@nvidia.com>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <DDK7N52VX059.202D7SPGFV8A9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

Thanks for your comments!



On 10/17/25 03:36, Alexandre Courbot wrote:
> On Thu Oct 16, 2025 at 4:49 AM JST, Daniel del Castillo wrote:
>> This patch solves the existing mentions of COHA, a task
>> in the Nova task list about improving the `CoherentAllocation` API.
>> I confirmed by talking to Alexandre Courbot, that the reading/writing
>> methods in `CoherentAllocation` can never be safe, so
>> this patch doesn't actually change `CoherentAllocation`, but rather
>> tries to solve the existing references to [COHA].
> 
> This mention of background discussions should be in the comment part of
> your commit (below the `---`).

Noted, will do for the next version of the patch.

>>
>> Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
>> ---
>>  drivers/gpu/nova-core/dma.rs            |  20 ++---
>>  drivers/gpu/nova-core/firmware/fwsec.rs | 104 ++++++++++--------------
>>  2 files changed, 50 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
>> index 94f44bcfd748..639a99cf72c4 100644
>> --- a/drivers/gpu/nova-core/dma.rs
>> +++ b/drivers/gpu/nova-core/dma.rs
>> @@ -25,21 +25,11 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
>>      }
>>  
>>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
>> -        Self::new(dev, data.len()).map(|mut dma_obj| {
>> -            // TODO[COHA]: replace with `CoherentAllocation::write()` once available.
>> -            // SAFETY:
>> -            // - `dma_obj`'s size is at least `data.len()`.
>> -            // - We have just created this object and there is no other user at this stage.
>> -            unsafe {
>> -                core::ptr::copy_nonoverlapping(
>> -                    data.as_ptr(),
>> -                    dma_obj.dma.start_ptr_mut(),
>> -                    data.len(),
>> -                );
>> -            }
>> -
>> -            dma_obj
>> -        })
>> +        let mut dma_obj = Self::new(dev, data.len())?;
>> +        // SAFETY: We have just created this object and there is no other user at this stage.
>> +        unsafe { dma_obj.write(data, 0)? };
>> +
>> +        Ok(dma_obj)
> 
> Can you preserve the use of `map`? This removes the need for the
> temporary variable.
> 

Sure.> <snip>
>>  /// The FWSEC microcode, extracted from the BIOS and to be run on the GSP falcon.
>> @@ -260,32 +245,38 @@ fn new_fwsec(dev: &Device<device::Bound>, bios: &Vbios, cmd: FwsecCommand) -> Re
>>  
>>          // Find the DMEM mapper section in the firmware.
>>          for i in 0..hdr.entry_count as usize {
>> -            let app: &FalconAppifV1 =
>>              // SAFETY: we have exclusive access to `dma_object`.
>> -            unsafe {
>> +            let app: &FalconAppifV1 = unsafe {
>>                  transmute(
>>                      &dma_object,
>> -                    hdr_offset + hdr.header_size as usize + i * hdr.entry_size as usize
>> +                    hdr_offset + hdr.header_size as usize + i * hdr.entry_size as usize,
>>                  )
>>              }?;
>>  
>>              if app.id != NVFW_FALCON_APPIF_ID_DMEMMAPPER {
>>                  continue;
>>              }
>> +            let dmem_base = app.dmem_base;
>>  
>>              // SAFETY: we have exclusive access to `dma_object`.
>>              let dmem_mapper: &mut FalconAppifDmemmapperV3 = unsafe {
>> -                transmute_mut(
>> -                    &mut dma_object,
>> -                    (desc.imem_load_size + app.dmem_base) as usize,
>> -                )
>> +                transmute_mut(&mut dma_object, (desc.imem_load_size + dmem_base) as usize)
>>              }?;
>>  
>> +            dmem_mapper.init_cmd = match cmd {
>> +                FwsecCommand::Frts {
>> +                    frts_addr: _,
>> +                    frts_size: _,
> 
> Can the `{ .. }` syntax be used here?
> 
Yes! I didn't remember that syntax.


>> +                } => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS,
>> +                FwsecCommand::Sb => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB,
>> +            };
>> +            let cmd_in_buffer_offset = dmem_mapper.cmd_in_buffer_offset;
>> +
>>              // SAFETY: we have exclusive access to `dma_object`.
>>              let frts_cmd: &mut FrtsCmd = unsafe {
>>                  transmute_mut(
>>                      &mut dma_object,
>> -                    (desc.imem_load_size + dmem_mapper.cmd_in_buffer_offset) as usize,
>> +                    (desc.imem_load_size + cmd_in_buffer_offset) as usize,
>>                  )
>>              }?;
>>  
>> @@ -296,24 +287,19 @@ fn new_fwsec(dev: &Device<device::Bound>, bios: &Vbios, cmd: FwsecCommand) -> Re
>>                  size: 0,
>>                  flags: 2,
>>              };
>> -
>> -            dmem_mapper.init_cmd = match cmd {
>> -                FwsecCommand::Frts {
>> -                    frts_addr,
>> -                    frts_size,
>> -                } => {
>> -                    frts_cmd.frts_region = FrtsRegion {
>> -                        ver: 1,
>> -                        hdr: size_of::<FrtsRegion>() as u32,
>> -                        addr: (frts_addr >> 12) as u32,
>> -                        size: (frts_size >> 12) as u32,
>> -                        ftype: NVFW_FRTS_CMD_REGION_TYPE_FB,
>> -                    };
>> -
>> -                    NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS
>> -                }
>> -                FwsecCommand::Sb => NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB,
>> -            };
>> +            if let FwsecCommand::Frts {
>> +                frts_addr,
>> +                frts_size,
>> +            } = cmd
>> +            {
>> +                frts_cmd.frts_region = FrtsRegion {
>> +                    ver: 1,
>> +                    hdr: size_of::<FrtsRegion>() as u32,
>> +                    addr: (frts_addr >> 12) as u32,
>> +                    size: (frts_size >> 12) as u32,
>> +                    ftype: NVFW_FRTS_CMD_REGION_TYPE_FB,
>> +                };
>> +            }
> 
> I liked that the original code updated both `init_cmd` and `frts_region`
> in the same match block. I understand it might be difficult to preserve
> due to the borrowing rules, but can you try to preserve it if that's
> possible at all?

I agree it was nicer. I tried to preserve it, but I don't see a way to
do it cleanly, as I can't keep both mutable references at the same time.
What I could do is only check `cmd` once, set `init_cmd` and store an
`Option<FrtsRegion>` that I will later use to set `frts_region` if it's
not `None`. Let me know if you prefer that.

Cheers,
Daniel


