Return-Path: <linux-kernel+bounces-858060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC8BE8BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19FF3BCF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E71342C90;
	Fri, 17 Oct 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxi4ooY2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0033321B7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706427; cv=none; b=LGI3fHTS6WjOkVIXKWIzc3UGnYXY4YbPG8uOKkWxPd45SHY0Dp5FtL+XLgsfUwhMGF+fcc4ufS5kFJKpOQzb94xxC2Z8497CUREDQQZN9jodbx+Uy1f/crjueE5qMFpGdJ2qStcfxPrqA55XKV0O0nL7W1I9amU0PK8c7QrFxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706427; c=relaxed/simple;
	bh=UlQGl1ScHrpEQGlp5xSK5Wvs9cVhOgIQeIG0lXECHuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRHejtfaJTWtpDI1uSZTMrXLXS3vn1qjJTmKBXS/C4S5rHEdkVsqQWvxRYlpEEU2uidIFhruT+jOIkc3NMeOBnM0d8L/X8GtpMyNvVCbUTFmkQP5KUqC7Z8qMNsjS8r7dQZiDJMfbZP/4ae2BdLPPut0qLcf2b2WP84lBRdvBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxi4ooY2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46fb328a60eso10999785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706424; x=1761311224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SprhfwBgGE9ehANfWOlvkOyYRUmTibUC89wBbYn2ZxQ=;
        b=rxi4ooY2VnUZVLeGuj0o6SHSSCt2DpRWnCd/2jZq265h6o/fLCPkLTd4dMEFx9Hu8Z
         di0WhFwBKOoexJx7t38LAdOl7OD9rnnrFl2x/zYwhpfML25AoHz5n0wz/lh7Zv8WadT1
         /F8Ns0/bCgfxoj5k+UzeLSe9h8mV2g7Ls8rvXf5XJjVse2HV3sNoEG8RRDfbXf6SprWw
         seeTbRocclwwPcDn59/+y25+pkAaD0Cl142bp/LXWQ6atiA4g37/UuOuaNdCBWoZRZuq
         tXx7e4hY5gtfp64BqJn8vcAEUxIaeKVKczbLOr6rg/66+XYyPE8cO86urTOoAeqWEmOF
         iVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706424; x=1761311224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SprhfwBgGE9ehANfWOlvkOyYRUmTibUC89wBbYn2ZxQ=;
        b=TVQ260wO4OrUjabCj7RwPUY3rB9rJFCLv3l5nCuPnHIEFvdGCQOex+U8/VH7Ex+OQk
         4mNwsCal+a/CwMWwMX8DorDSNZFKxtf+C2Szw0A3YHyX7fJGwAevDlikjC53abDLSzNE
         OJCqHztvRMNBJDi36Vph2V9tHsKzu2ETR/PXv3igPFHdLT9V1A8u0tTRpELErZu3nr+2
         zJWyQPLN3lkuJt8SGoK1FgV1dJAazazIberBgFjDFYafUnIKpQz0H8u6wcZW85uK/Xaf
         my8ZNopEid2oDJWBTAgSxyGO76Ee/kTkmFC0/kt2Sd3/5XWfw0gsa+2JC6KAAf9gmxrs
         3Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCXvf+zQt5eLzidIIF0lPVX7F+3tgWnUb7SOID7HIA9tZeCVl5huOi3DLUxst8z52I4nJ21q98ZcIoRC+tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kaAKqiY7D9mzvmGBTjCgjRMK/rlpRPabJ/rVRJCuutb9uTcE
	6lKAlx/2S9ooP/x1/HfcY7s/IhpvlhSLyzbcncDPPWMxBU2/HPxY+tqE8jz5Bw3yU9jqMoyATlO
	Gw8z4PhIHcHjWrL5LNQ==
X-Google-Smtp-Source: AGHT+IFC7yLsEvAPHfk7qNsNSq+04mGav0QhCDYZxT1xGf6tqBnc3CGyTXJOJDKdS84LHon9JPZg9QkSAmeZDCw=
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr24693625e9.41.1760706424497;
 Fri, 17 Oct 2025 06:07:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:07:03 +0000
In-Reply-To: <20251016133251.31018-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016133251.31018-1-dakr@kernel.org>
Message-ID: <aPI_d5Tzk2fZLMPg@google.com>
Subject: Re: [PATCH] rust: device: fix device context of Device::parent()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 03:31:44PM +0200, Danilo Krummrich wrote:
> Regardless of the DeviceContext of a device, we can't give any
> guarantees about the DeviceContext of its parent device.
> 
> This is very subtle, since it's only caused by a simple typo, i.e.
> 
> 	 Self::from_raw(parent)
> 
> which preserves the DeviceContext in this case, vs.
> 
> 	 Device::from_raw(parent)
> 
> which discards the DeviceContext.
> 
> (I should have noticed it doing the correct thing in auxiliary::Device
> subsequently, but somehow missed it.)
> 
> Hence, fix both Device::parent() and auxiliary::Device::parent().
> 
> Cc: stable@vger.kernel.org
> Fixes: a4c9f71e3440 ("rust: device: implement Device::parent()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

