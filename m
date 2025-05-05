Return-Path: <linux-kernel+bounces-631687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD91AA8BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356A317207C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 06:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3501885B4;
	Mon,  5 May 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/2LY2z/"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B41C3C18
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746424969; cv=none; b=i012mp6oF+Q95HBb9vmsXjxOw8ucQ4DlQyg5jxvE6AGOf8Yv0UyAGNsO9i4AN48+ityP8gVQJlXbqizWq2wGXJIHVjjbSKiIuaTYAsf6BZshRXu+RJgwTayJEOJtkT/rzcZge3KRfWpkNcgKWBBtMvZhVMk+XpRhWW/3lONM4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746424969; c=relaxed/simple;
	bh=HVKP4hAQquqF9RIcvTfvax2BhjJoAg/WOKY6ggK6lq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCpsLhMJ1hlNMAuvWdZEDQWWay4d7ZDT10FGJU5hO10jTsnSrzrGlp/G+Mcm7odZbu7yaf90+v8JkIqQtnz0f0bZaKLJIGOQqPld2yRRYLYBlUOFrA+wGjfo0e7WglglQWzTDL1UOYG8+J31C4eI5ZK01+oB2yC55JD7WI547vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/2LY2z/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so486992485a.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 May 2025 23:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746424966; x=1747029766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXO6ahkaisU7SY/MQI1b++2xzNSPFBdiiq3xVsO5fmA=;
        b=A/2LY2z/gze89agDs6iLapdDjjmkPuclSo0fvQl+BWAKxtYLi5b37pN1+cSQ3cN9cy
         6c4cg861OJ7ZihDJ3UcNT6cfz3uBdjAdEl7a+dag/B0U6tLTG+M+VKlnEfAksxY0bZ0L
         DALYGkFDVY6OpHFpd2u8fFVQUTE/D3cyrytGgtie92NgvK8zr9zHRMV44+7qdQK8kDEX
         riFpR93VoLJYFNOl6KfoaNhUR7PvwX4OS1KwcSCmIAbrBbeljkLaH9xoL/gY3qfPm9I+
         2fsBa4W/6Us8J/ZULHlZuVXm+62fM/jz041+JuIJGW/3xy3zgkwk19l7MO9EauIQf7O+
         A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746424966; x=1747029766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXO6ahkaisU7SY/MQI1b++2xzNSPFBdiiq3xVsO5fmA=;
        b=hItCzAUA08fNFCtvFXhRwv2xjqfJ68RDjK9Mqeg3OoCDwpDwOOlQPHtyU/UqbnXHhl
         KtO08YYn2sBGrhskxdnpDwk0xz63SgjlzL9cjJ5kL9zeRF0KT/t7O4julQHupaU5MHq1
         Gfi+noRjKLTI9mpgPLzZe1dhDxLJu57lSLHEBxeCpCF5/wkE1OdOhgXOma4UQ0djxXiS
         U2xXEtzB2wlcaTFXEfBMAGiR6gOZ2dl5mFvkdfM2B4Grw7w5W0IOq2mzDOhGWsrzIi6R
         mRGSWoUAS7j+5oXEC1KvUOVQJnQQ7SaYax2WhIeyXXhre8e1umXJMs8bpuq4BF1BXU+0
         c4xw==
X-Forwarded-Encrypted: i=1; AJvYcCWuKp0t6bQfQCna+Ru0Q+maPnkSgV/ttCOY+I9TVB0ESoiN55wP0qlX/sYhjtVFb8jsgXRiUxp2DrEV7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV51Mj4QQQGCNDhHe8at1gF+fkTQz3UuCrh8rLc/N6FXQaeSFY
	w+E+wfYFjZ8iDdOKohNZj14y9nhsxf21y4IPLZLPihlUZTDSrqexsV85bjy0NNBeQks2gqK2ML4
	N6XmbTAC3BW/i3r6WHngWfdFS9QXUYGgqKONX
X-Gm-Gg: ASbGncv5uF3zPD/KS9bENDbJ0otqUWHbZ+9WPydE+28LArbtqzNOHuuDD8px3NbJS30
	2MyxwlwITba2KodZI3hngKllyfyxk1uHcvVBzhpdpTppo7K5X0QsjayM1rEB/louR2V8Jn0EcVx
	GK7hZh8orxGxfXd6FbM7DjD70=
X-Google-Smtp-Source: AGHT+IE4DnG4pRCm1mH4QmS8Rr5Lk108bRyZO/mTGwd04eJ/aHT34k/YsdMdQhveNGbY40uVMmQk2pQN/VVxzF5TAQ4=
X-Received: by 2002:a05:6214:27eb:b0:6e4:4484:f354 with SMTP id
 6a1803df08f44-6f51580c049mr213459176d6.38.1746424965469; Sun, 04 May 2025
 23:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-6-ojeda@kernel.org>
From: David Gow <davidgow@google.com>
Date: Mon, 5 May 2025 14:02:34 +0800
X-Gm-Features: ATxdqUE7frjIVJXxylkdrYwlYKzmK5vZThcGfkvMfQ0ti-Z3sSLS_8q0vse-4Mo
Message-ID: <CABVgOSnvbJHQedsCeWXpa6bXVgHmRNsEzP3oFuOB3q_AUA4ugw@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bad70106345d3f3a"

--000000000000bad70106345d3f3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 May 2025 at 05:52, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Since now we have support for returning `-> Result`s, we can convert some
> of these tests to use the feature, and serve as a first user for it too.
>
> Thus convert them.
>
> This, in turn, simplifies them a fair bit.
>
> We keep the actual assertions we want to make as explicit ones with
> `assert*!`s.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

I prefer this, even though I actually don't mind the .unwrap(), just
because we'll funnel failures to KUnit properly, rather than having a
full panic from the unwrap.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  rust/kernel/str.rs | 68 ++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 38 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index cf2caa2db168..8dcfb11013f2 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -576,25 +576,9 @@ macro_rules! c_str {
>  mod tests {
>      use super::*;
>
> -    struct String(CString);
> -
> -    impl String {
> -        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
> -            String(CString::try_from_fmt(args).unwrap())
> -        }
> -    }
> -
> -    impl Deref for String {
> -        type Target =3D str;
> -
> -        fn deref(&self) -> &str {
> -            self.0.to_str().unwrap()
> -        }
> -    }
> -
>      macro_rules! format {
>          ($($f:tt)*) =3D> ({
> -            &*String::from_fmt(kernel::fmt!($($f)*))
> +            CString::try_from_fmt(kernel::fmt!($($f)*))?.to_str()?
>          })
>      }
>
> @@ -613,66 +597,72 @@ macro_rules! format {
>          \\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xf=
c\\xfd\\xfe\\xff";
>
>      #[test]
> -    fn test_cstr_to_str() {
> +    fn test_cstr_to_str() -> Result {
>          let good_bytes =3D b"\xf0\x9f\xa6\x80\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes).unwra=
p();
> -        let checked_str =3D checked_cstr.to_str().unwrap();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
> +        let checked_str =3D checked_cstr.to_str()?;
>          assert_eq!(checked_str, "=F0=9F=A6=80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_to_str_invalid_utf8() {
> +    fn test_cstr_to_str_invalid_utf8() -> Result {
>          let bad_bytes =3D b"\xc3\x28\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes).unwrap=
();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes)?;
>          assert!(checked_cstr.to_str().is_err());
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_as_str_unchecked() {
> +    fn test_cstr_as_str_unchecked() -> Result {
>          let good_bytes =3D b"\xf0\x9f\x90\xA7\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes).unwra=
p();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
>          // SAFETY: The contents come from a string literal which contain=
s valid UTF-8.
>          let unchecked_str =3D unsafe { checked_cstr.as_str_unchecked() }=
;
>          assert_eq!(unchecked_str, "=F0=9F=90=A7");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_display() {
> -        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
).unwrap();
> +    fn test_cstr_display() -> Result {
> +        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
)?;
>          assert_eq!(format!("{}", hello_world), "hello, world!");
> -        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0").unwrap();
> +        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0")?;
>          assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
> -        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").=
unwrap();
> +        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?=
;
>          assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
> -        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0").unwrap();
> +        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0")?;
>          assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_display_all_bytes() {
> +    fn test_cstr_display_all_bytes() -> Result {
>          let mut bytes: [u8; 256] =3D [0; 256];
>          // fill `bytes` with [1..=3D255] + [0]
>          for i in u8::MIN..=3Du8::MAX {
>              bytes[i as usize] =3D i.wrapping_add(1);
>          }
> -        let cstr =3D CStr::from_bytes_with_nul(&bytes).unwrap();
> +        let cstr =3D CStr::from_bytes_with_nul(&bytes)?;
>          assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_debug() {
> -        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
).unwrap();
> +    fn test_cstr_debug() -> Result {
> +        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
)?;
>          assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
> -        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0").unwrap();
> +        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0")?;
>          assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"=
");
> -        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").=
unwrap();
> +        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?=
;
>          assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
> -        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0").unwrap();
> +        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0")?;
>          assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\=
"");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_bstr_display() {
> +    fn test_bstr_display() -> Result {
>          let hello_world =3D BStr::from_bytes(b"hello, world!");
>          assert_eq!(format!("{}", hello_world), "hello, world!");
>          let escapes =3D BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
> @@ -683,10 +673,11 @@ fn test_bstr_display() {
>          assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
>          let good_bytes =3D BStr::from_bytes(b"\xf0\x9f\xa6\x80");
>          assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_bstr_debug() {
> +    fn test_bstr_debug() -> Result {
>          let hello_world =3D BStr::from_bytes(b"hello, world!");
>          assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
>          let escapes =3D BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
> @@ -697,6 +688,7 @@ fn test_bstr_debug() {
>          assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
>          let good_bytes =3D BStr::from_bytes(b"\xf0\x9f\xa6\x80");
>          assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\=
"");
> +        Ok(())
>      }
>  }
>
> --
> 2.49.0
>

--000000000000bad70106345d3f3a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgM4Adu9KwZhycveUS7StO4OOtxJf9
o+AnNDUYpxGhA+owGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA1MDYwMjQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAeriuMqNy2NMpQJQjlGcMlD6ZOBbOL1ELJJMMZFNP9DBfLuWyFjihfDIMtZymfIbG
KptiNxw9k9kZPQSxFWOVgP52cdK4fRFUk79refakegXs7usUxy0PAwGXFtubdCXdmJ8GRJw5dU67
MF/5wn4loaXDSI7dUGpZrAVwcEcGMphJxvg70n2xEt1q8u8sXRpVmweBxkYC/IpgZ3zDOuIfkHQu
sHEYfFWnB2og0yTddsFLbKjAN7YAyvJJK+KPADVgUUWrXiZ+SH2d0o7MoXueA7gpxVXb483DQbp4
u8VGzvefLvZzEJRrkU03/6tW139NfILTOlB3bK4cmq7Kqd4lxw==
--000000000000bad70106345d3f3a--

