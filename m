Return-Path: <linux-kernel+bounces-789406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66419B3950E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238DA1625D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B972D0274;
	Thu, 28 Aug 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="TcbUNeG/";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="lPJ11e5h"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56925782D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365729; cv=none; b=sMxGdfd8GuThJMUzge/WJxPvpx9n4ozLJw1vjl9KFcafCNB40VCM9S3Vy5TWyg3MoQCmA6K46u3wmP2RX32hY+KlJZRBXgPeFFLRhwow1Jrkmd0wMuBMe/+GSNY25QzquLBApv45RK5u1gzYBbW8XUaevnrQf3XHyOgeQjj7u8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365729; c=relaxed/simple;
	bh=WUueKzjbbqRI8uNwdF9+KLT8gmKFIXZLY8N7awD/wlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+Zw56AjQCPy6kuJBP0IqupezyU6tSMtDtLQt8Vg+4u68ewhgbR9SloOCVypbtVYu3GaPeNVHEhTgw33LFT/AYL9Ut5GJOuAkTZScf0AgSdqU0N1w+FZsUyGqo27Y0QHDq4MN3hynVMWd4jSQ+rjtC7HBcezL/TqhPEqZSU4WoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=TcbUNeG/; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=lPJ11e5h; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756365723; x=1756970523;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=2YfXwIt8uRuB24ocvEdwemGPCWUZNGhB6pqOxsa3SJ0=;
	b=TcbUNeG/Qd6OqSN287cQTmdl55p7z84ZIkeCBkDU3GIILprGfzuQ7Ik4bXeFOv5u5dMucEA1leH/j
	 u6cMu3yYFuMD3hFGcoBfWcAhlbyuEhYQ0cqzPQaCFNjQ63UC8RCPmIE50Ghz1kJL8CkHrCpeSGyKaQ
	 rEhzod0zsmBxDSfysQl6qGN4xyjljeiYJ95M4UBdX2D3Wg7h3hjGXEOpFY+jqbMhS/2V5KtflkrWL+
	 G3UQY0+4SJzUMooFb5K18Gfkbwiov48Zm4WP8mCtvkWcqHKKcmEYAn2pnLDNLdu+EVz4ZJh7ZQ30mk
	 lAmWsyPAVc0z5D1GXMGnPyczzYxeZSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756365723; x=1756970523;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=2YfXwIt8uRuB24ocvEdwemGPCWUZNGhB6pqOxsa3SJ0=;
	b=lPJ11e5hy9upngoLEXivO2ahV4GaS+cyXshxFqcORIa094aD9pjodBkqBSAZmjvmhhngAHoeXGbfK
	 FEge1gOAg==
X-HalOne-ID: b09ec1ec-83df-11f0-80cc-f3c0f7fef5ee
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id b09ec1ec-83df-11f0-80cc-f3c0f7fef5ee;
	Thu, 28 Aug 2025 07:22:02 +0000 (UTC)
Message-ID: <9c63dda1-0a4b-4131-a5e7-12ad2e88c6d6@konsulko.se>
Date: Thu, 28 Aug 2025 09:22:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
To: Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130522.867263-1-vitaly.wool@konsulko.se>
 <DCCIRTHGQFNX.1M8GXO4TYA7DF@kernel.org>
 <DFA3B588-3650-42DA-8875-7AB7D20A2BCA@konsulko.se>
 <DCDC2M7N28X2.3Q8XYNEDOGK6A@kernel.org>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <DCDC2M7N28X2.3Q8XYNEDOGK6A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/27/25 17:59, Benno Lossin wrote:
> On Wed Aug 27, 2025 at 4:24 PM CEST, Vitaly Wool wrote:
>>
>>
>>> On Aug 26, 2025, at 7:02 PM, Benno Lossin <lossin@kernel.org> wrote:
>>>
>>> On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
>>>> +pub trait ZpoolDriver {
>>>> +    /// Opaque Rust representation of `struct zpool`.
>>>> +    type Pool: ForeignOwnable;
>>>
>>> I think this is the same question that Danilo asked a few versions ago,
>>> but why do we need this? Why can't we just use `Self` instead?
>>
>> It’s convenient to use it in the backend implementation, like in the toy example supplied in the documentation part:
>>
>> +/// struct MyZpool {
>> +///     name: &'static CStr,
>> +///     bytes_used: AtomicU64,
>> +/// }
>> …
>> +/// impl ZpoolDriver for MyZpoolDriver {
>> +///     type Pool = KBox<MyZpool>;
>>
>> Does that make sense?
> 
> No, why can't it just be like this:
> 
>      struct MyZpool {
>          name: &'static CStr,
>          bytes_used: AtomicU64,
>      }
>      
>      struct MyZpoolDriver;
>      
>      impl ZpoolDriver for MyZpoolDriver {
>          type Error = Infallible;
>      
>          fn create(name: &'static CStr) -> impl PinInit<Self, Self::Error> {
>              MyZpool { name, bytes_used: AtomicU64::new(0) }
>          }
>      
>          fn malloc(&mut self, size: usize, gfp: Flags, _nid: NumaNode) -> Result<usize> {
>              let mut pow: usize = 0;
>              for n in 6..=PAGE_SHIFT {
>                  if size <= 1 << n {
>                      pow = n;
>                      break;
>                  }
>              }
>              match pow {
>                  0 => Err(EINVAL),
>                  _ => {
>                      let vec = KVec::<u64>::with_capacity(1 << (pow - 3), gfp)?;
>                      let (ptr, _len, _cap) = vec.into_raw_parts();
>                      self.bytes_used.fetch_add(1 << pow, Ordering::Relaxed);
>                      Ok(ptr as usize | (pow - 6))
>                  }
>              }
>          }
>      
>          unsafe fn free(&self, handle: usize) {
>              let n = (handle & 0x3F) + 3;
>              let uptr = handle & !0x3F;
>      
>              // SAFETY:
>              // - uptr comes from handle which points to the KVec allocation from `alloc`.
>              // - size == capacity and is coming from the first 6 bits of handle.
>              let vec = unsafe { KVec::<u64>::from_raw_parts(uptr as *mut u64, 1 << n, 1 << n) };
>              drop(vec);
>              self.bytes_used.fetch_sub(1 << (n + 3), Ordering::Relaxed);
>          }
>      
>          unsafe fn read_begin(&self, handle: usize) -> NonNull<u8> {
>              let uptr = handle & !0x3F;
>              // SAFETY: uptr points to a memory area allocated by KVec
>              unsafe { NonNull::new_unchecked(uptr as *mut u8) }
>          }
>      
>          unsafe fn read_end(&self, _handle: usize, _handle_mem: NonNull<u8>) {}
>      
>          unsafe fn write(&self, handle: usize, handle_mem: NonNull<u8>, mem_len: usize) {
>              let uptr = handle & !0x3F;
>              // SAFETY: handle_mem is a valid non-null pointer provided by zpool, uptr points to
>              // a KVec allocated in `malloc` and is therefore also valid.
>              unsafe {
>                  copy_nonoverlapping(handle_mem.as_ptr().cast(), uptr as *mut c_void, mem_len)
>              };
>          }
>      
>          fn total_pages(&self) -> u64 {
>              self.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
>          }
>      }

It can indeed but then the ZpoolDriver trait will have to be extended 
with functions like into_raw() and from_raw(), because zpool expects 
*mut c_void, so on the Adapter side it will look like

     extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_void {
         // SAFETY: the memory pointed to by name is guaranteed by zpool 
to be a valid string
         let pool = unsafe { T::create(CStr::from_char_ptr(name), 
Flags::from_raw(gfp)) };
         match pool {
             Err(_) => null_mut(),
             Ok(p) => T::into_raw(p).cast(),
         }
     }

The question is, why does this make it better?

> Also using a `usize` as a handle seems like a bad idea. Use a newtype
> wrapper of usize instead. You can also not implement `Copy` and thus get
> rid of one of the safety requirements of the `free` function. Not sure
> if we can remove the other one as well using more type system magic, but
> we could try.

Thanks, I'll surely look into this.

>>>> +
>>>> +    /// Create a pool.
>>>> +    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
>>>> +
>>>> +    /// Destroy the pool.
>>>> +    fn destroy(pool: Self::Pool);
>>>
>>> This should just be done via the normal `Drop` trait?
>>
>> Let me check if I’m getting you right here. I take what you are suggesting is that we require that Pool implements Drop trait and then just do something like:
>>
>>      extern "C" fn destroy_(pool: *mut c_void) {
>>          // SAFETY: The pointer originates from an `into_foreign` call.
>>          unsafe { drop(T::Pool::from_foreign(pool)) }
>>      }
>>
>> Is that understanding correct?
> 
> Yes, but you don't need to require the type to implement drop.
> 
> ---
> Cheers,
> Benno


