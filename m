Return-Path: <linux-kernel+bounces-860503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E98BF0496
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C4A4F4F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA22F6190;
	Mon, 20 Oct 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuAD4r1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB11F4CBF;
	Mon, 20 Oct 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953283; cv=none; b=dnhKiQJx0eHFmUI/S/X5m2gOau42TOH3dseyBbcQS7UUosZkT05yNm2O6zI3qe936PLrDJaCLZhDsOkcTLzQ3Ip8ZimZU5OzZvKzQbnfSEuWu9PSezEDmGnaNS/mzBgM70J97SsBdAO+kEVvYZOCK7DV7lAoCpAhmlTY3qPqBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953283; c=relaxed/simple;
	bh=eJfnJW4ukGkMPFLCa8Ry+/E5fvPjm0Fowub/NxTm7RE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=to8zjiLThuXZ5LHWCMpROL86vfa77UQSxaTJgIVL6kbptDu4enH7Zk/KD4R5IUQvfvnfNCx/6Qv3g1MK5QmVzx4UtgOJsr2+BImrJ1qYpxlAzFDZpSxMPXC7J+Rlr20bCBaquJ3Ygyw+uUgkyHOqLE2t/l+UhXvNrN+UAiogXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuAD4r1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA3CC4CEF9;
	Mon, 20 Oct 2025 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760953282;
	bh=eJfnJW4ukGkMPFLCa8Ry+/E5fvPjm0Fowub/NxTm7RE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ZuAD4r1vvJXLKTMZR8RwPqFcTcOHb2WsOoOgQyQB5XhnPLR6EDnx1ezuBOt7OxcFW
	 gD1eA7jHR3t/OpvXtQ/F4g3+Yb9WQMznY9hqsfRr8bbcSNjUkCAqpexNEW8xTLEe5Q
	 rJtzZlVl1AfzPDgTkRMSTkZWiGz1MBtpox0i3SLqAMGOngSEScOrfP9UUlac+4G4+c
	 HkWqUhpWUsAIeagU+cPRH3qU/ltjKZWSGrp+6ftYeCzSDA8He6P/Ic5HQ8ravzGH9Q
	 4ppPM6MPwQTkIy0SrjKtVVv47NsW3JXtPbdmX71xWoZzenwcON5hfP25kCGRsIHkBX
	 ojOvUe4Ajrt1w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 11:41:18 +0200
Message-Id: <DDN1U7ZVN7O7.1OL96WGTK3VJK@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org> <aPS0aTUUwDsXmHFN@google.com>
 <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org> <aPXvJPcSgZdNlGtB@google.com>
 <DDN1PLK58C34.2XF7BCBQNAW5X@kernel.org> <aPYDY8mdHWjyOU3l@google.com>
In-Reply-To: <aPYDY8mdHWjyOU3l@google.com>

On Mon Oct 20, 2025 at 11:39 AM CEST, Alice Ryhl wrote:
> On Mon, Oct 20, 2025 at 11:35:15AM +0200, Danilo Krummrich wrote:
>> On Mon Oct 20, 2025 at 10:13 AM CEST, Alice Ryhl wrote:
>> > I ended up using i64 for simple_read_from_buffer in iov.rs instead of
>> > loff_t. But if they can differ, then yeah let's introduce a loff_t typ=
e
>> > alias.
>>=20
>> No, I don't think they can differ (I used i64 in earlier version that di=
dn't
>> make it to the list as well), but I think it could still make sense to i=
ndicate
>> the relationship with loff_t. When I see an i64, an offset into a buffer=
 is not
>> the first thing that comes to my mind.
>>=20
>> What about uaccess::Offset?
>
> Hmm. That seems wrong. loff_t is a *file position*, so it should go in
> kernel::fs, right? We're only using it in uaccess/iov because they
> happen to have utility methods to help with implementing fops entries.
> None of the "base" uaccess/iov functions use loff_t for anything since
> they deal with sizes in the address space, for which usize is the
> correct type.

Indeed, fair enough.

