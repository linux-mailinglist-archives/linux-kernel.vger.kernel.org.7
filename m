Return-Path: <linux-kernel+bounces-748327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1ADB13F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891483B2D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C3274676;
	Mon, 28 Jul 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A36/Ik78"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6027465B;
	Mon, 28 Jul 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718656; cv=none; b=AeYOO69MCHD+QAMCTTdcz0uUqk3v2FCRKfFVeKsTJp/tB2PFEHqIeQHEsegOLPPgweIAAgjiD27Cb+WbPWFOIuxufmJgi9Au1BsbgZS8lSDEfVIM3Goc/XoZeez7t+yBQtRyZFTIMyMIQK5PDUksf/fAGXYHspUZfPu1K1BNT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718656; c=relaxed/simple;
	bh=agDLCpdC8g2e8J4abTCfvumW9noFxzdN+V6Xz5PYvlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpyYc80qy39hH6bmiKeZ71JNK0wM5ojC3TfUiW4g6M9yms5H+t8Vm1PuS64pknG4mNhXHinpOs+HomwVakV4ErGLxoOIHXyuEZtIb+Tk9gMzRfHbuLo0T8YZCFXrh95KwZHHVD4LzKe26A6TBzGU2bw7YlATDBWZ9lmB16HVRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A36/Ik78; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e62a1cbf81so677629485a.0;
        Mon, 28 Jul 2025 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753718654; x=1754323454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgVIowzMLl/c31IEtlhtiNAMDBO1tT9OzRoFR/KHf0s=;
        b=A36/Ik782HXOclxZwgdPoQE8bq9SqZotXX6QlQ+PeP/22Z+8963LChOCbDtjjPycu5
         gpMNwKdi83xDSc7fLrwwuGo5TltUPXJsnl3oxgQzGUemZ5C+XPVqsnv2lAcQ20S4B7+w
         orJQHaQiZXQ1gqZY3NW8S9pwvwEAJTxvOxqBXSavmGyFtNFH32XY0X6/iZuEFVe+Scz8
         mSeb6lxqZNfYmXINbOxvJxdj6hVie4iEtSXJFJLwADW13hNJdOSrUX6QmQUvfTwgq+4D
         SnEod9CFJYda3fnzP82jCG5YRR6RvfoSIWAoYLjWxWz3OSExhjIP49B9H1XvkBre/TZC
         J8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718654; x=1754323454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgVIowzMLl/c31IEtlhtiNAMDBO1tT9OzRoFR/KHf0s=;
        b=Ers3Eki/1KU5CGshenC73pNeTI9voPqvXYjGJHqYHCKUNOGIh9DltV8N7GlVeNJ6x3
         sI0OVCVCL5ftva7EpLg5UsIoDCncY3OrqeKVO5XFHU/XFWGH6wh0VN3bTpTa4SaNZHqA
         tHxQUYXC7SnYAc82skOO6DVHls1D3kiBiV4TO4ED5IsyYjZoKGzgcSFXCTJ5w3FGUqn0
         6LuQGLpIX3R+xTIgeAF+Q6Bof7f3ONbOZO/jRodhuii54RooCQeHnNYGDxJYlRa7wv3h
         hXJFN/aMxyqeyB/BquKdP167E+deVsOSBONQva5oYA/tUvuw2ICRVkSCqdrOAoHA2UWR
         gw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwiekfXDG8Fp69tR2g9AGE6AQrGJ0qfFI39no2wwB1B+TGhyKwwe+zp6TU79JhZcXGirOHTh3mtQUfWQJxMrI=@vger.kernel.org, AJvYcCWe5yCllWSDqbOfpbMYNnjGTYH3PC244kK4kyhVN9wnKPT4wxvrRe36/yt9LPIQjjqWkdsvlwhTv6CDxzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxe83F4vsYgNvnY81WXwotArnOSzlLjrV33eBkSSiXcetzpT/2
	DUOCQxW1eH53nbGkBp8XhpIQZqMhGauk7OYKvEPhK5AvcG1eEDSe+MEA
X-Gm-Gg: ASbGncuM7MgvGZJyDlfakSGyrhIN76mBbrs4CQ2GUCA9jg31BJKvIMe7+sksNtxg1hO
	CCfQgyKEW5/u8COrAzlJppsqR8AmOQn6KzLeHKOOB2hC8jGQukDVfIAwrmaW2CXQG4ok2Ckvg74
	caxwfKg/AfNH1SAyy70xLG3jjp8pCKhFgfOF3SDbJ94XSOkbO3k7tQASuvOrgVvQjjt8DEdO5SF
	WpeveaUnwtsEX+Wve+zLQWRegLazRIOaZz5DIpfWCHqwvNQuTxNMydEABvVG1uGEXNdwTHc6T6J
	ZXR9txa4dg7q5/5XyZIDsp16wdT4tyf3P5unwRXBdDBvsFF4W4qhtpI7VplmFzkuXDJipK/RY8r
	smnTo1OZUbi2XBkFDFIyynOLVL4X549EyOk5nKOksKiY0R12jPHYAxjZEN122zUSqHNF/h2G80L
	9HUwbVbxAbIajLcJ10sr0pIuw=
X-Google-Smtp-Source: AGHT+IEmoTOimrTi2PNwl6GvbwncBwk/yYnnS0+QBiPbPf62rdY0sZGQQYXhaQaKI8ltuQpaCRWGkw==
X-Received: by 2002:a05:620a:563c:b0:7e3:35dd:4829 with SMTP id af79cd13be357-7e63c1b69d0mr1382664085a.46.1753718653785;
        Mon, 28 Jul 2025 09:04:13 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327a9f8sm310642085a.11.2025.07.28.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:04:13 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C91B1F40068;
	Mon, 28 Jul 2025 12:04:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 28 Jul 2025 12:04:12 -0400
X-ME-Sender: <xms:fJ-HaJVwNHByxbizTaFL_NER2N37NTwgoKEb0jMl_OQ3uuyT1UGY6g>
    <xme:fJ-HaETTgsEhTJJspf20pgVrxrirrLIuAUkbGpWuk_MnzyG8y31p7gVlOvYMUbARZ
    w-OUHSWcJfW_OyAmQ>
X-ME-Received: <xmr:fJ-HaOHVtFYOz-xyAP51tE2ZT7cGGndoVjmgWD9UoGjNqfN1scySsbEpqZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihgrmhdr
    hhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrsh
    htohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrvgifjhgsrghllhgrnhgtvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehloh
    hsshhinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fJ-HaDfZiGYJ_3Y_Tv78lK9koMKzRMQkbu7rYDJsdsrEbSNIOqdc-Q>
    <xmx:fJ-HaFKlZNUj93B0NFuErw-NffZVTfT6I5JbtLUsxxYl9m3pfbB50A>
    <xmx:fJ-HaCqs2447yRAv2B1Ykj6aWSNTyAolHdv0LNj7tNbnUbzNyX5fOg>
    <xmx:fJ-HaLXik3XNSFJN8ohWVPRYXN1vi75UQF_g-Y_c0dyVx1NzL7qszw>
    <xmx:fJ-HaN3XQe-MWz8vmkHtMpvdV3nVjiKoFXbQb-7JmpYAAkaNBgRNAID6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 12:04:12 -0400 (EDT)
Date: Mon, 28 Jul 2025 09:04:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
Message-ID: <aIefe_MEPd_yicde@tardis-2.local>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>

On Sat, Jul 26, 2025 at 01:23:22PM +0000, Alice Ryhl wrote:
> The maple tree will be used in the Tyr driver to allocate and keep track
> of GPU allocations created internally (i.e. not by userspace). It will
> likely also be used in the Nova driver eventually.
> 
> This adds the simplest methods for additional and removal that do not
> require any special care with respect to concurrency.
> 
> This implementation is based on the RFC by Andrew but with significant
> changes to simplify the implementation.
> 
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
[...]
> +    /// Free all `T` instances in this tree.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This frees Rust data referenced by the maple tree without removing it from the maple tree.
> +    /// The caller must ensure that no reference that remains in the maple tree is used incorrectly
> +    /// after this call.
> +    unsafe fn free_all_entries(self: Pin<&mut Self>) {
> +        // SAFETY: The pointer references a valid maple tree.
> +        let ma_state = unsafe { Opaque::new(bindings::MA_STATE(self.tree.get(), 0, usize::MAX)) };
> +

A meta comment here for the future direction: I think it really makes a
lot of sense if we could have the Rust abstraction for struct ma_state,
that'll allow us to have flexible locking strategy and Iterator-like
interface. Maybe it's something Andrew can take a deeper look when
MapleTree binding is in-tree (no word play intented ;-))?

For example, with a ma_state binding, we can do:

    let mas = MAState::new(self, 0..);

    while let Some(v) = mas.next() {
    	drop(v)
    }

Regards,
Boqun

> +        loop {
> +            // SAFETY: The maple tree is valid. This call to `free_all_entries` has exclusive
> +            // access to the maple tree, so no further synchronization is required.
> +            let ptr = unsafe { bindings::mas_find(ma_state.get(), usize::MAX) };
> +            if ptr.is_null() {
> +                break;
> +            }
> +            // SAFETY: By the type invariants, this pointer references a valid value of type `T`.
> +            // By the safety requirements, it is okay to free it without removing it from the maple
> +            // tree.
> +            unsafe { drop(T::from_foreign(ptr)) };
> +        }
> +    }
> +}
> +
[...]

