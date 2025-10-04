Return-Path: <linux-kernel+bounces-842111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD1BB9006
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75773BD028
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB627FB12;
	Sat,  4 Oct 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="kPjxNPdS"
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF9200BA1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596244; cv=none; b=qVv54lwhWzNfQy6cnh7rLF973nqas0xBfxQwuDhbd5jy4mjWq1SXCyIbLHEq/ifwyglyKPfZW+H5uwdSnZU2tpHRoePAHeLDKys0RHswyN/o6XSNeyawfCx1nvjpbAlwwUcqq27xmE2XsoymIosWKA2g9VKK3BcBm9qrbzSB3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596244; c=relaxed/simple;
	bh=2LWaKyQDGbNBobcP3+9XFS0f4uG8GULKxwdhoblzB5k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=actINt1BL6rxQLgAwa/mmNKx+vvjKNnmGKdkG+iMMNGKMMjZ6qakH1t4qiJDhoYqRgIWVJn7H7Ey5gHmQmv30fTt/zTpGWNsikQfQUcBqVTxj69iOgrxDAWHKULdySJqaxblXhj5QnnYYK6KLPgO/hz4M/fyivzVh2fVKuXNv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=kPjxNPdS; arc=none smtp.client-ip=98.137.69.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1759596241; bh=o0VJNtk+fex4FcVQUZ6R8JHfG23W+4ZASJpfX5z5ENo=; h=Subject:From:To:Date:In-Reply-To:References:From:Subject:Reply-To; b=kPjxNPdSetk+UWsttM+8WA7jtXrM010O5bq22SCgNyKoJ2KsLuJ2c/wvk+KDjGM2A2+Z67KagmfBaXcQnWVAXwKmDEygobfAlvycI0m85xB1GwsUAoQpKPsyvyklcR3+Sb2uI9iboS1Whz0ckqRgjXaEzHRLZNmDY5F7f2Unhqnf3hWbpI2+hCMJiltgI6zSLwSrIQd4ZT/QrLVD5+ejv/PtgDeQPwjLQB0fnlSMz70c0EOfcyEZ5TbHbpkOIfklq5fLmrd5XjxHYu6WZZADS+ZoryG35DfQUtqCgQKZSL33xr9Efvqqt5+uqrZ8zXtiIZiCzNqJJY5jxB+u5BTzfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759596241; bh=m2dzbzJFK/k8d7cnUiFoCRXSNfzPEtFlA2QsxTYn3Lv=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=X9LtQOe8hLVZSt40rUhjLAiAkkncv3caevHuUcMq1Gi7JnX+GK0paWFmLbI2VEh/zTcfn1guEzmzSrFuPPSQ/HYmO0Ap6RW5ctzqL/b84wzr6HT8hx6XoRJ7qdFe4tg0SPjewT93yjA88bnIrH+j2Is9UINErZ+dXYI2D7hBHigpwbc//anopdIcrrJj1zOw9vlOSeWCarjN5/0kQ7j+U2qV9pcRdutogl1PAY8ydfXcCyPOx4CPHGvs9wctm4b8eZAmRXAM0+nDeIrbLp2XmvHaWGY7G6ZccPzgsr3sCSPZj0yAHfdmTRrKgXxgWetfTeeToApY24SHrohDTDueIw==
X-YMail-OSG: lpPUJBIVM1nQQUWY5sRICzMbaPkmBT.eDn7mXkP4sKCbZBcLivbgzNhYotPZhMQ
 xPX2Xjt2hz6Kv1bog5uivRanOg19pLIvNQLLFqgfRKjLBSnn2VcvShVgnuxEY4u1tw0WKuHEIfsp
 DKegXfkh.6h03z5ggbmljb8bQM2_mlecFPjK2OmqrHDsgTWiqipCK8Z14QBRtAAbcyGYVIdLwL88
 rOh71GXA_e4ljWbGQAHpBGiHxwwG1xYyYPf.ebpXuRrHnsEHqqI9jki9Gji.MGilkM5BqVL9A6cQ
 UtYJ_NqDkflZ82rAH_ewVoJGLVY6D8VtBcmh6RarP8hPO0nlyMkbefEc_9gtYbVcOR7d.g6Yloi8
 5yqA4yayVfpiUqLrpJVM5enEmzPBJQQ_R1wjxxxeEjFCvs6nMm3Bogj8FtbiIQjH43Xn8V0tMSrF
 saR7Xu8yzRmWkzO0Q98NR8m2gCUn8FfDaUZodoGgpPKI8tbGreyrvzmcVY71N5eEKV5NAIJNDByS
 aMzZB8k2RJ_xjeUYzxzp9BEperfBdb3IA2cnX1q_5a1YZB02bBZkZe9EoLLzN1qB81zVHhKg2Kdf
 uT.9R_OgDxelIQoEHQ8xGBF9xEXf2t.z.a4ZMbdfTtWMWA6QTZCKkdCwdLgj2voZYIPTEqn93IX9
 EZZx_emoYKNjMjOu2tUSpk2tSdtTj4.zpeVWfvmIkHK3XS95X8W64b8c6m.JHC3_hAFPA91Tn88Q
 _cYtnV_WkmMaAAzBUUtriT8PU6SkycgdK_jLuCNyeA5bmH9pyq1bisZEmLCZVjTkygAs.qBP9LGX
 Uj.rQVItED5CABt6j.31JgAWW3Gm7v8A50htUHFh93jF79wqcBSrYBrlw6Y7hVTCjFlxrTHZiFJh
 oVq.Tw.8YajMp4Kz8m4Xp37XrZ1Vfha1asbItLi3whvHT4NMl.f98rWBFo1ImNQjpZ_mpckQkjTy
 GDBoHqoGmr_my0uaoZoWyGcf7ULWvOupHExvUhKEm9x8jyY15WkaCSLf1u8bnGaSqCW62qFPPIrx
 H70owC5tV5kED1gS0iQgFeA8h5y65bJvhUUzGGRmERlrxahOMT3xgAE2qqqoTHvVppw2SPsmVoqz
 9f_30tGBtWkhoRLM2yKBZDdpgy064skZjnvHtr7Ve0..iqpAD_yHbBnM27ZAkCNEV2yb9FbVHN0O
 21KWg7BLODatGkXd7wgXeKykJTlVVlM.4PngP8AXS9_GD8hFww8orDZADZ4LS3h8Gxr1osMltmkp
 SR_9L777L0dBR5DAKNwu3ANSccD1A48_q8WOmmQ2HYHERMuMfIpEBHKGQacxtN.XWe_eUt4iChza
 _Ymb7ghCdjMXm6Ve6w69JamG3UMV5c5jrGKKM4eB9os1mue2XzNbt.2QrxpDNgBWw0B_ye1TQLZ4
 P5zMREy.m0Dw_4zdDNg.w8QcdQv6_mUKU9BB2mvpAilt01FaWk.ThXFiTSKZwJEOet3SUg5ZGNUn
 b3eLVTGZUJV_BIVy6MCh.Qm1kH0CF_Qep_rIKHQ_84vrMY8564Fy_Jj97b6EOFNxaWE9hLEyAN3A
 Jjq92cfdP9yzlZBXRRjA73zzRHBKBWsAVZ3CG7XfSkhQ9xGhX6.k5JEF5PXO_C0zEE04.84O5zdz
 B9tp3Iy9psV37a.K6v9tibCcNzOfBJU89y9Mkat1fUHiqWHhzGUcK3EGosXK9BNE7ICiXscXSoZJ
 6AfxMnu62740fIh6lkOtuVmZyEJZ1rgh251UPuJLjVH6dwGKCLzyS4VtFIkFE4gsfJBc8GtHxffz
 qs6VQ7PhjMJyiLJJu2sOheg0LN0S2uO5exRoD_kNhwO7ujRcMaSPaEfBp4mW.pSbxum6Jv_5H9lW
 MOgChK6ut2h4yPoZl4n_zFPjN_VvIsEEgCzxhQE09c5N6s39z7KehEGMcppt9DOhvI.XO4ldgpRQ
 CMtMztj1Tc66pbCGLXMdeX5h6viqlHS2ZgNzs_l3cSNb1Yvh3X.omVbcWCc.pvJQAuUCDiAbWBmp
 1eFI5VtyFeTlJhpDqw0GQ1ESOBBZVmpsEVDbz9ag3B66DLdns2t3MR7Ly1WZBBeEU.dL_VuIKoLh
 7wBw0f.bt94jNCqkwS3b0tA_jCxy6wU7MYewWRMPBF5o7gnZA34G7.PpKG_2bbDxILCBkXGhn3Ur
 swMOU_1wo4jJGZxbeN53wgr2QF5iVnnHgzYSfPf0vUm32Uh9HLjiI5sctsrRZ6Z16xFyP5Ic8RZR
 oNrMKhROy6q9lKA_2ndWHVKI2Ahz6zyFqA.5A.jFzo5clcHQE
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 16c46f4e-def7-4a04-a537-da3d54d9ecbb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 4 Oct 2025 16:44:01 +0000
Received: by hermes--production-ir2-ccdb4f9c8-rkdr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ad1631f89b5f0cb7bb9af10e2f9f060;
          Sat, 04 Oct 2025 16:13:36 +0000 (UTC)
Message-ID: <d957bb721c9039287833ca0a9e2cebd60943c5f8.camel@aol.com>
Subject: Re: [PATCH v2] drm/gud: Use kmalloc_array() instead of kmalloc()
From: Ruben Wauters <rubenru09@aol.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 	airlied@gmail.com, simona@ffwll.ch, mingo@kernel.org, tglx@linutronix.de, 
	jfalempe@redhat.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, 	skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Date: Sat, 04 Oct 2025 17:13:33 +0100
In-Reply-To: <20250923085144.22582-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923085144.22582-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24485 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tue, 2025-09-23 at 09:51 +0100, Mehdi Ben Hadj Khelifa wrote:
> Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
> calculation inside kmalloc is dynamic 'width * height' to avoid
> overflow.
>=20
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

Acked-by: Ruben Wauters <rubenru09@aol.com>

> ---
> Changelog:
>=20
> Changes since v1:
> - Use of width as element count and height as size of element to
> eliminate the mentionned calculation and overflow issues.
>=20
>  drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 8d548d08f127..8898dc9393fb 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struc=
t drm_format_info *format
>  	height =3D drm_rect_height(rect);
>  	len =3D drm_format_info_min_pitch(format, 0, width) * height;
> =20
> -	buf =3D kmalloc(width * height, GFP_KERNEL);
> +	buf =3D kmalloc_array(width, height, GFP_KERNEL);
>  	if (!buf)
>  		return 0;
> =20

