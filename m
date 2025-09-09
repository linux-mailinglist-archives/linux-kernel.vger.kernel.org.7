Return-Path: <linux-kernel+bounces-808829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C8B50533
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A988A5453A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1C35E4E3;
	Tue,  9 Sep 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UCWp/A1x"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA535CECA;
	Tue,  9 Sep 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442405; cv=pass; b=PCvnh7nywe8QKyV3hHSoKJUBPsgQP+q3E8vPA5dd2cTQqYal8qHUnZOW05xrC8HatKky7mjUFVKwsdANZR49JuWBaGoaixsauIlJoj8Rtqy5bPMWw6QXXTY1wqDgvFPZ3IKfTbhLvkYKnRwNjwFH1po2jfSx1MAxiDm+P5tbjpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442405; c=relaxed/simple;
	bh=EayG+sH3R0eCnt700Qx4vg2NGQ3Ytrre1KIutSJAS6k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U5mXnC8oX4dMCKJLuUs+v5W2kkrS5EKtduxxaCsD0iX/seF+i2rlO0L21l7xK4W11cEnj7aFMSVOsGVUNPy3heZLJG0We8fshqNf7hy+DGdOOPrNUBpyj96PjoDr37PBuudkuXBbRglU92dQFTsXoatT5yNjNl75rEFqh/r3meQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UCWp/A1x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757442374; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nfTRfMOqeG9w6aDxLnwLbvyIyX5koxc9pr+zPW/qH6svofI8E4pSSee5rRxiN6fBQIX3QGx+mXnwuXTYUalbk/ZPgjpiR4ZOf15jlAc1iupl7G5brKLWRQsBlwOJO1UHj7xdlrj/5YZV6pE4aybyC1xxR7rCSbifrS/qvnuYrHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757442374; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fs5CsFfLcfoJGwWM4PqAb1r7RQf/UPHfitNCCRiMcPk=; 
	b=QCGkd33vBzvStY4TqHxcJ9bP+XqJtRmycspu+rMaBdFqwM1KGFs9tWZJ9rkjhRz4tQjRg97Pi5ENPQPgQMmN60S8+ZS1IN3dXMmnET6RffUdLCtmAEItPdmullef3tPnUZS+49y8aMsLRRZ64hoDFUltMcQN2aHm0PUtgcHyh+M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757442374;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=fs5CsFfLcfoJGwWM4PqAb1r7RQf/UPHfitNCCRiMcPk=;
	b=UCWp/A1xRtsCuYJOm9xIAT5JjdoDxgINTQG5xQ+cGYtwq7DrLhBxF+lrhKW1rUm8
	untsaPuA6uwZ7TFroDGvewvCe5BXEW0t7B3fJT9Vgz3Z3gfAC7YtAtU1rAKnLMBlbAT
	rpt8v7HyLSkR3pfyd8P9Vv01bypAWYht6SuX1xWw=
Received: by mx.zohomail.com with SMTPS id 1757442371658939.5893008501465;
	Tue, 9 Sep 2025 11:26:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250909204308.74ccedf4@nimda.home>
Date: Tue, 9 Sep 2025 15:25:55 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 daniel@sedlak.dev,
 dirk.behme@de.bosch.com,
 felipe_life@live.com,
 tamird@gmail.com,
 dakr@kernel.org,
 tmgross@umich.edu,
 aliceryhl@google.com,
 a.hindborg@kernel.org,
 lossin@kernel.org,
 bjorn3_gh@protonmail.com,
 gary@garyguo.net,
 boqun.feng@gmail.com,
 alex.gaynor@gmail.com,
 ojeda@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <468A76F2-FC02-4B54-974B-7C52D946ECEB@collabora.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
 <20250909170013.16025-2-work@onurozkan.dev>
 <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
 <20250909204308.74ccedf4@nimda.home>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Onur,

> On 9 Sep 2025, at 14:43, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> On Tue, 9 Sep 2025 19:17:56 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>=20
>> On Tue, Sep 9, 2025 at 7:01=E2=80=AFPM Onur =C3=96zkan =
<work@onurozkan.dev> wrote:
>>>=20
>>> This patch only fixes the callers that broke after the changes on
>>> `to_result`. I haven't included all the improvements made possible
>>> by the new design since
>>=20
>> I think Daniel asked in the previous version what you mean by =
"callers
>> that broke" here -- it is a bit confusing, since it seems this is a
>> fix (and thus needs to be prioritized).
>>=20
>> Is that the case?
>>=20
>> Thanks!
>>=20
>> Cheers,
>> Miguel
>=20
> What I meant is that the change on `to_result` signature introduced a
> breaking change so I had to update its callers accordingly.
>=20
> The fix I mentioned in this version is a different matter.
>=20
> Before the rebase, the regulator module had a get_voltage function =
like
> this:
>=20
> let voltage =3D unsafe {...};
>=20
> if voltage < 0 {
>     Err(...)
> } else {
>     Ok(Voltage::from_microvolts(voltage))
> }
>=20
> But on the regulator/for-next branch, a patch was applied that changed
> it to:
>=20
> let voltage =3D unsafe {...};
> to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
>=20
> That change was incompatible with v1 (due to the different signature =
of
> to_result), which fails to build with my patch. This version (v2)
> fixes the issue introduced in v1.

Fixes what issue? What is the actual problem being addressed here?

It looks like a mere change from

to_result(=E2=80=A6) and,
to_result(=E2=80=A6).map()

To:

to_result(=E2=80=A6)?;
Ok(())

and

-        let voltage =3D unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) };
-
-        to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
+        to_result(unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) })
+            .map(Voltage::from_microvolts)
    }


>=20
> Sorry for the confusion, I hope it's more clear now.
>=20
> Thanks,
> Onur
>=20

Your last regulator patch was minor, correct, and was picked up =
(merged). It
cleared up an if/else, so that was an improvement.

I now see yet another change, doing apparently the same thing (correct =
me if
I=E2=80=99m wrong) in a slightly different way, in a patch that now has =
your previous regulator
patch as a dependency.

So my question is, why do we need this?

diff --git a/rust/kernel/regulator.rsb/rust/kernel/regulator.rs
index 34bb24ec8d4d..a5f357bda6e9 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -260,15 +260,15 @@ pub fn set_voltage(&self, min_voltage: Voltage, =
max_voltage: Voltage) -> Result
                min_voltage.as_microvolts(),
                max_voltage.as_microvolts(),
            )
-        })
+        })?;
+        Ok(())
    }

    /// Gets the current voltage of the regulator.
    pub fn get_voltage(&self) -> Result<Voltage> {
        // SAFETY: Safe as per the type invariants of `Regulator`.
-        let voltage =3D unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) };
-
-        to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
+        to_result(unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) })
+            .map(Voltage::from_microvolts)
    }

    fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
@@ -288,12 +288,14 @@ fn get_internal(dev: &Device, name: &CStr) -> =
Result<Regulator<T>> {

    fn enable_internal(&self) -> Result {
        // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) })
+        to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) })?;
+        Ok(())
    }

    fn disable_internal(&self) -> Result {
        // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) })
+        to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) })?;
+        Ok(())
    }


=E2=80=94 Daniel=

