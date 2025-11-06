Return-Path: <linux-kernel+bounces-888119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A5C39E25
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B166421BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01230CD9D;
	Thu,  6 Nov 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfkPEZgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680030C61F;
	Thu,  6 Nov 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422252; cv=none; b=AtMl82bifZ4W7x2eggIUoAb5vrgfS3TTvK0Jsvqj7uZxtI7pdaFlWWY+474GTD0uD2ZWciFHI9N9PI276lLlwBXo2F9f63OP2PQ68s8iMoo4/4X4Vxp81W/VMt/qOTleXiR8uaNAZvAanOM+MlhCfTJbqG/WDWn7itqgwC+4vAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422252; c=relaxed/simple;
	bh=diLhr3aX7Cr3ejy3u4Szb56argNLsib/ykfKtLUwPWw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XmFEVbkqSchFquPtMh4XC4RYtEOtKb2VPSSfCj/5ENRLZ3Z5zXLlz7SJiXjopDnSksHJYuVclDMa8sOyKjUa49A7lxYA5gB+aew9gkboTQJWbOBcCwzjju0Xjt5NIqUjwFSRrfojpEadqRPo40Kr+L/G0AZAiNMrtis0FmkFGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfkPEZgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB15C4CEF7;
	Thu,  6 Nov 2025 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762422251;
	bh=diLhr3aX7Cr3ejy3u4Szb56argNLsib/ykfKtLUwPWw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qfkPEZgIe4YJsQkgci/RlAeP91q5VWAc2A3/FJOfsI3tR+uoAviSi+A2vxPxz/ekh
	 x0pnG/DT0NtFKtEYKoh7BWeXa6Yh6kzEr32wr7jqzDN0SpOIMSMm1C8FIi2yMaS9A+
	 BxLIC5pPjVG008ccr4+d9GaIul/3+Tmwcd3ER02E5m7ee1qmtpOBhU6YkNUtlMU9+A
	 etm6UoyL1ImAev0FSJuhUjz7hz2ETp0jjHtuwIHE2JSmhu8WeatNzSUq24uI+VHUlP
	 cXnZ+YCCzTrtSZOvJud5OYIRKNDWWWK0/onKiNMJVuMkj2Q9tRV5YRtsxLxhYvc/2w
	 eCa+uSRtgQ1HA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 10:44:06 +0100
Message-Id: <DE1IJMY33LSW.2X8N4PYXFITVB@kernel.org>
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and
 start_ptr_mut()
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251103190655.2326191-1-dakr@kernel.org>
In-Reply-To: <20251103190655.2326191-1-dakr@kernel.org>

On Mon Nov 3, 2025 at 8:06 PM CET, Danilo Krummrich wrote:
> @@ -576,7 +580,7 @@ pub fn item_from_index(&self, offset: usize) -> Resul=
t<*mut T> {
>          // and we've just checked that the range and index is within bou=
nds.
>          // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
>          // that `self.count` won't overflow early in the constructor.
> -        Ok(unsafe { self.cpu_addr.add(offset) })
> +        Ok(unsafe { self.start_ptr().cast_mut().add(offset) })

In this specific case start_ptr().cast_mut() is indeed a bit odd, I will us=
e the
following hunk instead and keep the raw access.

@@ -576,7 +580,7 @@ pub fn item_from_index(&self, offset: usize) -> Result<=
*mut T> {
         // and we've just checked that the range and index is within bound=
s.
         // - `offset` can't overflow since it is smaller than `self.count`=
 and we've checked
         // that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { self.cpu_addr.add(offset) })
+        Ok(unsafe { self.cpu_addr.get().add(offset) })

